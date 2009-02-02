From: Uli Luckas <u.luckas@road.de>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Mon, 2 Feb 2009 12:00:59 +0100
Message-ID: <200902021200.59992.u.luckas@road.de>
References: <Pine.LNX.4.44L0.0902011219170.27579-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902011219170.27579-100000@netrider.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: Brian Swetland <swetland@google.com>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sunday, 1. February 2009, Alan Stern wrote:
> Early-suspend seems to be a completely different matter. =A0In fact it
> isn't a suspend state at all, as far as I understand it. =A0It's more
> like what you get simply by doing a runtime suspend on some collection
> of devices. =A0I don't see that the kernel needs to treat it as a special
> state, and in might be possible to have a user program manage the whole
> thing -- provided the drivers in question implement runtime power
> management (as USB has done).
>
> Alan Stern

Except you always want early-suspend and auto-suspend at the same time. The =

idea is, if all display of system states is off (early-suspend), we can =

enable or disable the cpu at will (auto-suspend) because nobody will notice=
. =


Uli


-- =


------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
