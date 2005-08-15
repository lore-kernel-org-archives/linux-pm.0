From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Software suspend support in Fedora.
Date: Mon, 15 Aug 2005 14:06:35 +0200
Message-ID: <20050815120635.GA15382@elf.ucw.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3004311E37@hdsmsx401.amr.corp.intel.com>
	<20050731222751.GA28907@redhat.com>
	<20050803092301.GA1352@elf.ucw.cz>
	<20050813051642.GB11456@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67495154517736822=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050813051642.GB11456@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============67495154517736822==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

>  > > The outcome: I'm no more enthusiastic about enabling this in Red Hat
>  > > kernels than I ever was before.  It seems to have real issues with LVM
>  > > setups (which is default on Red Hat/Fedora installs these days).
>  > > After convincing it where to suspend/resume from by feeding it
>  > > the major/minor of my swap partition, it did actually seem
>  > > to suspend. And resume (though it did spew lots of 'sleeping whilst
>  > > atomic warnings, but thats trivial compared to whats coming up
>  > > next).
>  > 
>  > I do not know much about LVM. How exactly did you resume= command line
>  > look like? You were not resuming from initrd, right?
> 
> Indeed, this was very likely the problem. Doing a resume if I had
> any partition mounted was *bad* news.  We implemented the necessary
> bits in our initrd today to detect resume partitions, and erm.. resume them.
> So far so good, no repeats of the corruption I saw.

Aha, good.

> As of tomorrow rawhide kernels (for the unenlightened: these will
> eventually be FC5) will have software suspend support.
> 
> Our initial experiments with it have been fairly positive, though as
> expected there are a number of drivers that don't survive the resume
> correctly. http://www.livejournal.com/users/kernelslacker/22975.html

I see, having ext3 (or anything else) mounted when doing resume is
going to kill you data, fast. I thought warning in docs was good
enough :-).

Anyway, if you want to make this idiot-proof, I think the preferred
way is to kill suspend signature during the boot [it is must-have for
failsafe boot, so you can recover system if resume crashes it]. That
way user can echo whatever to resume, but having no signature means he
is not going to cause big damage.

[Actually there are more easy ways to kill some data. Suspend, do
normal boot next time, change something on disk, reboot and make it
resume. Bye-bye data.]

Okay, I realized I had too many warnings in there, and some things
(like no driver support) is not _that_ dangerous, while resuming with
filesystems mounted clearly is. I'll probably change the warning to:

 * BIG FAT WARNING *********************************************************
 *
 * If you touch anything on disk between suspend and resume...
 *                              ...kiss your data goodbye.
 *
 * If you do resume from initrd after your filesystems are mounted...
 *                              ...bye bye root partition.
 *                      [this is actually same case as above]
 *
 * If you have unsupported (*) devices using DMA, you may have some
 * problems. If your disk driver does not support suspend... (IDE does),
 * it may cause some problems, too. If you change kernel command line
 * between suspend and resume, it may do something wrong. If you change
 * your hardware while system is suspended... well, it was not good idea;
 * but it wil probably only crash.
 *
 * (*) suspend/resume support is needed to make it safe.



								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============67495154517736822==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67495154517736822==--
