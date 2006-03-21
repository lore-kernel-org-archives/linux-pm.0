From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: which page should be saved?
Date: Tue, 21 Mar 2006 10:42:30 +0100
Message-ID: <20060321094230.GM24523@elf.ucw.cz>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
	<1142557935.26706.26.camel@sli10-desk.sh.intel.com>
	<20060317065937.GH2674@elf.ucw.cz>
	<1142907568.11430.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36231061553149368=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1142907568.11430.16.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============36231061553149368==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Ok, I guess it is okay to go in if it stays in -mm for long enough to 
> > get a lot of testing.
> I'll do more tests and back to you. BTW, I wonder if BIOS already saved
> reserved memory (those doing communication with OS) in the 'platform'
> method of S4.

Yep, it should be safe. I bet it will break some obscure machine, but
it will probably fix some obscure machine, too... Just needs lots of testing.

> > > Anyway, skipping kernel text should be safe, isn't it?
> > 
> > It probably is. But you need to save modules. 
> I just consider the region from kernel start(1M) to the end of rodata.
> In my test, the region is about 4M memory. Just adding several lines to
> save 4M memory is worthy.

Well, few lines to save 4MB is nice. OTOH 4MB are saved in about
100msec, and if it brings in hard-to-debug bug on obscure
machine... we did not win much.

> > And we do use some 
> > self-modifying code these days, no? (Called runtime patching or 
> > something like that.) 
> Alternative instructions? The resume OS will do the same modification
> anyway.

Okay, hopefully.

> > Ouch and IIRC top-level pagedir or something 
> > like that lives in kernel "text" -- it is in assembly and wrongly 
> > placed.
> i386 does the right thing and put the pagedir in data segment. x86_64
> not, I think we could clean it up.

This probably should be done, first, and gotten past Andi.

								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...

--===============36231061553149368==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36231061553149368==--
