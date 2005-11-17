From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 21:12:04 +0100
Message-ID: <20051117201204.GA32376@dspnet.fr.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com>
	<1132172445.25230.73.camel@localhost>
	<20051116220500.GF12505@elf.ucw.cz>
	<20051117170202.GB10402@dspnet.fr.eu.org>
	<1132257432.4438.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============12417305577121152=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132257432.4438.8.camel@mindpipe>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============12417305577121152==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2005 at 02:57:11PM -0500, Lee Revell wrote:
> On Thu, 2005-11-17 at 18:02 +0100, Olivier Galibert wrote:
> > On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
> > > Now... if something can be
> > > done in userspace, it probably should.
> > 
> > And that usually means it just isn't done.  Cases in point:
> > multichannel audio software mixing, video pixel formats conversion.
> 
> What are you talking about?  ALSA does mixing in userspace, it works
> great.

You have an interesting definition of "great".

1- It doesn't work without an annoyingly complex, extremely badly
   documented user configuration. To the point that it doesn't work in
   either an out-of-the-box, updated Fedora Core 3 nor an
   out-of-the-box gentoo.

2- It doesn't work for programs that do not use the annoyingly complex
   and horribly documented alsa library, which includes everything
   that still uses OSS[1].

You call that great?  Multiple audio streams is such a basic feature
it should work, period.  No if, no buts, and no obligatory library.
Which doesn't preclude having it in userspace, mind you.  But it
should never have been the _application_'s responsability.

  OG.

[1] Which is so easier to use for normal programs' audio it's not
    funny.

--===============12417305577121152==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============12417305577121152==--
