From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 09:53:48 +0100
Message-ID: <200902180953.51171.oliver__38389.2812104479$1234947393$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0902162144010.24097-100000@netrider.rowland.org>
	<200902180026.55533.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902180026.55533.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Wednesday 18 February 2009 00:26:53 schrieb Rafael J. Wysocki:
> > Another possibility is to set up independent runtime PM for the
> > transport and the device. =A0This means allowing the possibility that t=
he
> > transport is suspended while its child (the device) is not. =A0This is a
> > little simpler (there's only one idle-timeout per device, since the
> > link is treated as an independent device), but it violates the
> > principle of never suspending a parent while there is an active child.
> =

> Well, I think the first approach would be better.

I am afraid it wouldn't be. How do you deal with shared transports?

	Regards
		Oliver
