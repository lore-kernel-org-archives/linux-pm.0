From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: I need some serious help to debug suspend to ram
	problem
Date: Sat, 27 Sep 2008 18:01:37 +0200
Message-ID: <200809271801.38449.rjw__24579.8865486451$1222531193$gmane$org@sisk.pl>
References: <48D4E685.8030801@gmail.com> <200809271515.50250.rjw@sisk.pl>
	<48DE4902.1080405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DE4902.1080405@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 27 of September 2008, Maxim Levitsky wrote:
> Rafael J. Wysocki wrote:
> > On Monday, 22 of September 2008, Maxim Levitsky wrote:
> >> Rafael J. Wysocki wrote:
> >>> On Sunday, 21 of September 2008, Maxim Levitsky wrote:
> >>>> Maxim Levitsky wrote:
> >>>>> Rafael J. Wysocki wrote:
> >>>>>> On Saturday, 20 of September 2008, Maxim Levitsky wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I hit a dead end when trying to understand why my notebook can't 
> >>>>>>> resume from suspend to ram
> >>>>>>> if this is done two times a row.
> >>>>>>>
> >>>>>>> Single suspend/resume cycle works almost perfectly (beep that goes 
> >>>>>>> through the sound card is muted... no morse code for me... :-(
> >>>>>>>
> >>>>>>> )
> >>>>>>>
> >>>>>>> I compiled a minimal kernel (absolutely nothing but disk drivers, all 
> >>>>>>> experimental option like nohz
> >>>>>>> turned off)
> >>>>>>>
> >>>>>>> But I had to turn SMP, since without it system won't resume first 
> >>>>>>> time I suspend it.
> >>>>>>> (How could this affect suspend?)
> >>>>>> It could if the system is 64-bit.  In which case please have a look at
> >>>>>> http://bugzilla.kernel.org/show_bug.cgi?id=11237
> >>>>>>
> >>>>>>> With SMP and minimal kernel (of course  no closed drivers), I get 
> >>>>>>> same behavior,
> >>>>>>> first resume works second hangs.
> >>>>>>>
> >>>>>>> I then added some debug code to real mode wakeup code, I put there in 
> >>>>>>> first
> >>>>>>> place instructions, that will save some magic value to rtc (to alarm
> >>>>>>> registers that I know are preserved during boot cycle), and I 
> >>>>>>> discovered   sad thing that first time bios does pass control to 
> >>>>>>> linux, but second time
> >>>>>>> (when it hangs), it doesn't.
> >>>>>>>
> >>>>>>> I tried to update bios, and I got same results.
> >>>>>>>
> >>>>>>> Of course it does work with that @#$%^& OS
> >>>>>> So we're doing something wrong.  Please try the appended patch.
> >>>>> Thanks a lot, but this didn't help.
> >>>>>
> >>>>> It still has same pattern, first suspend/resume works perfectly, second 
> >>>>> suspend/resume hangs hard.
> >>>>> It always happens like this, first resume always work (unless I turn off 
> >>>>> smp in kernel (I test this again), or reserve all low memory)
> >>>>>
> >>>>> Also note that if I suspend the system to ram, resume, and then suspend 
> >>>>> to disk, then I can suspend to ram and resume, it seems that
> >>>>>
> >>>>> on suspend to ram cycle somehow arms BIOS or something else, so second 
> >>>>> resume in a row doesn't work.
> >>>>>
> >>>>> I run 32 bit kernel here, this is a long story (this bios doesn't turn 
> >>>>> fan on when running 64-bit version, I could update it, and I know that 
> >>>>> fan issue is fixed there, but new bios introduces bigger bug, namely it 
> >>>>> makes fan to run almost always regardless of 32/64 type of os.
> >>>>> And it doesn't fix this suspend/resume issue, I tested this. I could 
> >>>>> start/stop fan manually with a script, but this could fail, and maybe I 
> >>>>> will do so someday.)
> >>>>>
> >>>>> The bugzilla seems to be unrelated here, since bios does pass control 
> >>>>> there, but corrupts memory.
> >>>>> Here I also have seen that bios corrupts memory, but everything resumes 
> >>>>> fine first time, and on second time,
> >>>>> bios doesn't pass control (I put set of instructions in beginning of 
> >>>>> wakeup real mode assembly file, no page tables, GDT/LDT are used there)
> >>>> I did same test for kernel without SMP, yes it hangs on first resume, but bios
> >>>> does pass control to linux, so while this is a minor bug, it is unrelated.
> >>> Still, I'd be interested in debugging this one too, if possible.  That may be
> >>> easier too. ;-)
> >> I take a look at that.
> >>
> >>>> I also tested noapic, pci=nommconf. No luck.
> >>>>
> >>>> Pattern is always the same, first resume works always, second doesn't.
> >>>> It is sad since first resume is almost perfect (when I have free time I need to look at sound codec datasheet
> >>>> and fix few issues there, anyways here alsa has few issues, all this is trivial, I already fixed all issues with desktop
> >>>> which has a sigmatel codec)
> >>> If you have more than 2 GB of RAM, you can try iommu=soft .
> >>>
> >>> I guess that all of the /sys/power/pm_test tests are passed?
> >> Well, I didn't run /sys/power/pm_test. 
> >> But this system has rock solid suspend to disk, I use it always.
> > 
> > Please look at http://bugzilla.kernel.org/show_bug.cgi?id=11415 .
> 
> Hi,
> 
> 
> I took a look there, but it doesn't seem to be similar to my issue,
> my issue is much bigger :-(
> 
> They tell that 2.6.24 works, but here nothing works, I was never able to do
> two suspends in row.
> 
> What I did find interesting was that they mention hardware locks of several kind there, so I am thinking
> could that be related to EC code, could it be that EC code confuses it somehow, so next boot doesn't work?
> Some hardware lock that kernel forgets to unlock, and that prevents bios from resume
> 
> Here ec switches to polled mode almost instantly, due to that bogus 'interrupt storm', I tried to increase interrupt threshold,
> and no more polled mode, but nether working second resume :-(

Have you tried the patch from http://bugzilla.kernel.org/show_bug.cgi?id=10724#c142 ?

Rafael
