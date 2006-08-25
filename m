From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 22:08:39 +0200
Message-ID: <20060825200839.GE9568@elf.ucw.cz>
References: <EA12F909C0431D458B9D18A176BEE4A5074D04AB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5074D04AB@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > No, it is because USB enabled prevents cpu from sleeping; it is
> > actually well known.
> =

> I vaguely recall hearing the why.  It has some DMAs which are going on
> and I suppose the processor must service the completions.
> Now, if you coordinated with the USB device some how, you could try
> > and

If I coordinated with USB device somehow, I'd know when it is possible
to shutoff usb bus. This can be done locally at usb driver, no need
for big framework. Just someone needs to write that code.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
