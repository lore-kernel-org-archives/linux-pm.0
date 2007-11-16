From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Fri, 16 Nov 2007 13:43:19 +0100
Message-ID: <20071116124319.GA21978__42683.8184278042$1195217083$gmane$org@elte.hu>
References: <473C7495.40805@rtr.ca> <20071115181418.GA6603@ucw.cz>
	<473C825E.3030307@rtr.ca> <20071115193424.GA31691@elte.hu>
	<20071115193612.GA751@elte.hu> <473CC6D4.2010909@rtr.ca>
	<20071116055531.GA16273@elte.hu> <20071116071522.GA1453@elte.hu>
	<20071116082146.GA14685@elte.hu> <20071116112317.GA12724@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071116112317.GA12724@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> so here's an UP suspend+resume trace i did:
> 
>   http://redhat.com/~mingo/latency-tracing-patches/misc/trace-suspend-long.txt.bz2
> 
> tons of detail - which might be interesting to other folks as well. 
> Fact is, our suspend-to-RAM+resume cycle is very, very slow, even on 
> fast hardware - and this trace shows all the reasons why.
> 
> This was a fully cached system - i.e. i've done a suspend+resume 
> before to warm up the caches. (not that suspend+resume does much IO 
> normally.)
> 
> The trace shows that a suspend+resume cycle is 7.95 seconds long 
> (without counting the time the box spent suspended) - ouch! This was a 
> T60 with Core2Duo 1.83GHz.

and the amount of time spent executing on the CPU was only 70 msecs! So 
we spent 99% of that 7.9 seconds with just waiting around. Here are the 
top 10 sleep reasons:

    864  schedule()<-schedule_timeout()<-ps2_sendbyte()<-ps2_command()
    183  schedule()<-vt_waitactive()<-vt_ioctl()<-tty_ioctl()
    164  schedule()<-schedule_timeout()<-acpi_ec_wait()<-acpi_ec_transaction()
    157  schedule()<-refrigerator()<-get_signal_to_deliver()<-do_notify_resume()    
    118  schedule()<-worker_thread()<-kthread()<-kernel_thread_helper()
     80  schedule()<-do_msleep()<-msleep()<-sata_link_debounce()
     64  schedule()<-schedule_timeout()<-inet_csk_accept()<-inet_accept()
     37  schedule()<-__mutex_lock_slowpath()<-mutex_lock()<-acpi_ec_transaction()
     20  schedule()<-schedule_timeout()<-do_select()<-core_sys_select()
     20  schedule()<-io_schedule()<-sync_buffer()<-__wait_on_bit()

what's weird are all those ps2 related sleeps - they make up for much of 
the delay. This how such a sleep point looks like:

    bash 3500  0D... 8641415us : schedule()<-schedule_timeout()<-ps2_sendbyte()<-ps2_command()
    bash 3500  0D... 8641417us : psmouse_sliced_command()<-synaptics_pt_write()<-ps2_sendbyte()<-ps2_command()

it starts somewhere here:

    bash 3500  0.... 5302376us : serio_reconnect_driver (serio_resume)

and ends:

 kseriod 208   0D... 9182560us : synaptics_query_hardware()<-synaptics_reconnect()<-psmouse_reconnect()<-serio_reconnect_driver()

so this section (serio_resume()) took almost 4 seconds.

the main delay seems to be dpm_resume():

    bash 3500  0.N.. 3061040us : dpm_resume (device_resume)
...
    bash 3500  0.... 9105017us : mutex_unlock (dpm_resume)
    bash 3500  0.... 9105018us : mutex_unlock (device_resume)

6.1 seconds!

	Ingo
