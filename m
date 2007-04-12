From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Thu, 12 Apr 2007 18:42:32 +1000
Message-ID: <1176367352.5764.2.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <461D494D.3080808@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> I doubt your reasoning is cogent enough. If you add such a global thing,
> you should prove it, or clearly explain what is the thing for.
> I don't believe that it's not possible to solve that decrementer case
> without this change. Can't you add appropriate platform_device which
> would register early enough, to meet that timing requirement when it
> gets suspended?

That's would be absolutely disgusting... (relying on magic ordering of
platform devices).

The fact is, the architecture needs to do various things around the
IRQ disabling and enabling, and thus we should have a hook for it.
I fail to understand why there is so much resistance here...

Ben.
