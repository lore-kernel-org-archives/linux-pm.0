From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 14:35:09 -0700
Message-ID: <p2vd6200be21005071435hf75ed42dnff2c2c02118e97__41759.4665814706$1273268222$gmane$org@mail.gmail.com>
References: <20100507180152.GH387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
	<20100507195548.GN387@atomide.com>
	<20100507202859.GA27328@srcf.ucam.org>
	<20100507205329.GP387@atomide.com>
	<20100507210304.GA28701@srcf.ucam.org>
	<1273267820.3542.120.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1273267820.3542.120.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 7, 2010 at 2:30 PM, Daniel Walker <dwalker@fifo99.com> wrote:
> On Fri, 2010-05-07 at 22:03 +0100, Matthew Garrett wrote:
>
>> Here's a different example. A process is waiting for a keypress, but
>> because it's badly written it's also drawing to the screen at 60 frames
>> per second and preventing the system from every going to idle. How do
>> you quiesce the system while still ensuring that the keypress will be
>> delivered to the application?
>
> To me it's somewhat of a negative for suspend blockers. Since to solve
> the problem you give above you would have to use a suspend blocker in an
> asynchronous way (locked in an interrupt, released in a thread too)
> assuming I understand your example. I've had my share of semaphore
> nightmares, and I'm not too excited to see a protection scheme (i.e. a
> lock) which allows asynchronous usage like suspend blockers.
>

Why do you think this? The example in the documentation describe how
we handle key events.


-- =

Arve Hj=F8nnev=E5g
