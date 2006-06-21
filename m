From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:18:15 -0700
Message-ID: <200606211418.16236.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150852207.12507.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201933510.5498@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 June 2006 7:40 pm, Linus Torvalds wrote:
> =

> It's not up to the driver to worry about request queues. =


Maybe for block drivers.  But USB and network controller drivers
are fundamentally about managing request queues, by collaborating
with upper level drivers.

Alternatively, you may be observing that just like block queues
are managed by the upper layer code, so are USB queues managed
by the usb_driver entities that freeze their own contributions,
like network interfaces manage their network queues.  (Though in
both cases the controller drivers must still wait for queues to
empty before they are fully quiesced).

- Dave
