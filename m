From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 13:47:29 +0200
Message-ID: <200704131347.30001.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176454756.7052.98.camel@johannes.berg>
	<1176455273.5764.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176455273.5764.74.camel@localhost.localdomain>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 April 2007 11:07, Benjamin Herrenschmidt wrote:
> =

> > The docs in the patch I posted should make it clear enough, but if
> > somebody can come up with a better name for "activate" I'm all ears.
> =

> I personally quite like your original irq_off/irq_on :-)
> =

> But I won't put up a fight for it if others disagree..

Well, I didn't like them, because they should refer to the local CPU only (=
the
other ones are supposed to be disabled at that point).  Also, since we are
going to do some things apart from disabling the (local) IRQs in there, I
thought some other names would be better.  Still, if that's confusing, I'm =
not
going to fight either. :-)

Greetings,
Rafael
