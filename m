From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 16:15:22 +0100
Message-ID: <4740570A.5030101__37921.5121189647$1195399059$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
	<200711181603.26522.rjw@sisk.pl> <474050EC.5080507@gmail.com>
	<200711181623.20029.rjwysocki@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711181623.20029.rjwysocki@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?B?IlJhZmHFgiBKLiBXeXNvY2tpIg==?= <rjwysocki@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 11/18/2007 04:23 PM, Rafa=C5=82 J. Wysocki wrote:
> On Sunday, 18 of November 2007, Jiri Slaby wrote:
>> On 11/18/2007 04:03 PM, Rafael J. Wysocki wrote:
>>> Can you also make the new System-map available, please?
>> Sure:
>> http://www.fi.muni.cz/~xslaby/sklad/System.map1
>=20
> The last notifier called in http://www.fi.muni.cz/~xslaby/sklad/susp_ha=
ng2.png

Last... Note, that it's only first 20 invokations of notifiers, there are
bazillion of them when I remove the condition '< 20'.

> is apparently cpu_swap_callback() which is not called in
> http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png .
>=20
> Can you verify that cpu_swap_callback() gets called if the patch is not
> applied?

Does this still apply?
