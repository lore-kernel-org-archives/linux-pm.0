From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to RAM on MSI PR200YA - do not recover,
	system immediately turns down
Date: Sat, 10 Oct 2009 23:34:42 +0200
Message-ID: <200910102334.42399.rjw__4822.03599899567$1255210614$gmane$org@sisk.pl>
References: <37b436160910101054t7765c253ta98b983f226b57c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <37b436160910101054t7765c253ta98b983f226b57c3@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Hujnak <hujnak.ondrej@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, mschmidt@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday 10 October 2009, Ondrej Hujnak wrote:
> Hello,
> 
> I am trying to make work "Suspend to RAM".
> My laptop is MSI PR200YA, linux
> kernel 2.6.30.8-64.fc11.i586 (fedora 11, 32bit),
> the same is with 2.6.31.1-56.fc12.i686.
> Motherboard - MSI 1221, graphics:
> Mobile GM965/GL960 Integrated Graphics Controller
> 
> When I do suspend to RAM it seem to work ok, it sleeps.
> But when I want to wake it, it only switches off (the power
> LED stops blinking).  If I'm having my notebook connected
> to electricity, after start it don't  start screen and keyboard.
> Notebook is running, but there is no HDD activity according
> to the LED indicator. When it is on battery, it normally starts,
> as if I had switched it normally off. Every time after trying to
> suspend it to RAM, on the next start I have
> "last write to superblock in future".
> 
> I tried:
>  - suspend from "single" mode
>  - suspend from "single" mode with as many modules as possible rmmod'ed
>  - using "nomodeset"
>  - early suspend-to-RAM at boot test with "test_suspend=mem"
> All with the same result.
> 
> I also tried using pm_trace, but this gave no useful results in dmesg
> in the next boot. The clock was not changed by it (the documentation
> said it would be).
> 
> I have attached printout of "lspci -vv" and "dmesg" after switching
> pm_trace on.
> 
> I'd welcome any ideas how to debug this further.
> I'm looking forward to your reply.

Does the pm_test 'core' test work (please see
Documentation/power/basic-pm-debugging.txt)?

Rafael


> 
