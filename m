From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Sat, 27 Feb 2010 13:00:56 +0100
Message-ID: <201002271300.56741.rjw@sisk.pl>
References: <4B86F96A.1010306@maroy.hu> <201002252357.04056.rjw@sisk.pl>
	<4B88D6B9.2050200@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B88D6B9.2050200@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-2?q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 27 February 2010, =C1kos Mar=F3y wrote:
> Rafael,
> =

> > Hmm.  Then perhaps you need this patch:
> > http://patchwork.kernel.org/patch/81830/
> =

> having applied this patch, hibernate behaves the same :(

Does it also happen if you rmmod the xhci-hcd module manually and run
"echo disk > /sys/power/state" afterwards?

Rafael
