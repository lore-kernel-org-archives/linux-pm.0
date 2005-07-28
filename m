From: david-b@pacbell.net
Subject: Re: Re: [PATCH 1/23] Add missing
	device_suspsend(PMSG_FREEZE) calls.
Date: Wed, 27 Jul 2005 19:21:51 -0700
Message-ID: <20050728022151.3B048DAA01@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<1122400462.4382.13.camel@localhost>
	<m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82335900871963641=="
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
To: ncunningham@cyclades.com, ebiederm@xmission.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============82335900871963641==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> And there is of course the puzzle of why there exists simultaneously
> driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
> are defined to do exactly the same thing.

No puzzle; that's not how they're defined.  Both of them cause the
device to quiesce that device's activity.  But:

 - shutdown() is a "dirty shutdown OK" heads-up for some level
   of restart/reboot; hardware will be completely re-initialized
   later, normally with hardware level resets and OS rebooting.

 - freeze() is a "clean shutdown only" that normally sees hardware
   state preserved, and is followed by suspend() or resume().

Or so I had understood.  That does suggest why having FREEZE in the
reboot path could be trouble:  you could be rebooting because that
hardware won't do a clean shutdown!

- Dave


--===============82335900871963641==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82335900871963641==--
