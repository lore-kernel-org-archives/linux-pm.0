From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 19:07:53 +1000
Message-ID: <1176455273.5764.74.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
	<1176377017.5764.15.camel@localhost.localdomain>
	<461E6E07.5020408@gmail.com> <1176454756.7052.98.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176454756.7052.98.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> The docs in the patch I posted should make it clear enough, but if
> somebody can come up with a better name for "activate" I'm all ears.

I personally quite like your original irq_off/irq_on :-)

But I won't put up a fight for it if others disagree..

Ben.
