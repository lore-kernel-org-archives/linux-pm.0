From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Re: [PATCH 1/23] Add missing
	device_suspsend(PMSG_FREEZE) calls.
Date: Thu, 28 Jul 2005 10:44:17 +0800
Message-ID: <1122518657.2925.4.camel@linux-hp.sh.intel.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<1122400462.4382.13.camel@localhost>
	<m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============81635601590246143=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, ncunningham@cyclades.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============81635601590246143==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-07-27 at 19:12 -0600, Eric W. Biederman wrote:
> Nigel Cunningham <ncunningham@cyclades.com> writes:
> 
> > Hi.
> >
> > Could you please send PMSG_* related patches to linux-pm at
> > lists.osdl.org as well?
> 
> I'll try.  My goal was not to add or change not functionality but to
> make what the kernel was already doing be consistent.
> 
> It turns out the device_suspend(PMSG_FREEZE) is a major pain
> sitting in the reboot path and I will be submitting a patch to
> remove it from the reboot path in 2.6.13 completely.
> 
> At the very least the ide driver breaks, and the e1000 driver
> is affected.
> 
> And there is of course the puzzle of why there exists simultaneously
> driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
> are defined to do exactly the same thing.
I would expect more driver breakage and for the shutdown either. In
current stage, suspend(PMSG_FREEZE) might put devices into D3 state. How
can a shutdown() be done again?

Thanks,
Shaohua


--===============81635601590246143==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============81635601590246143==--
