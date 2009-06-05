From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Fri, 5 Jun 2009 12:07:56 +0900
Message-ID: <aec7e5c30906042007t26915c05rd8ef375b8d4a353c__12455.0419780009$1244171521$gmane$org@mail.gmail.com>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<200906012133.32074.rjw@sisk.pl>
	<aec7e5c30906012133w74d7d843jccad99c564a308ec@mail.gmail.com>
	<200906031101.56577.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906031101.56577.rjw@sisk.pl>
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
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 3, 2009 at 6:01 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Tuesday 02 June 2009, Magnus Damm wrote:
>> If you guys dislike adding arch specific data to struct platform
>> device then for SuperH we can just (mis)use the arch specific data in
>> struct device instead. I'm afraid that solution wastes memory since
>> the data will only be used for platform devices anyway. So I prefer
>> adding arch specific data to struct platform_device instead of struct
>> device if possible.
>
> BTW, what is the difference really? =A0You can always put
> dev.platform_data =3D NULL for devices that don't have any platform data,
> can't you?

So the convention is that dev.platform_data points to driver-specific
data. It may or may not be required by the driver. The format of this
data is driver specific and should be the same across architectures.

What I'm trying to add with struct pdev_archdata is a place for
architecture specific data. This data is needed by architecture
specific code (for example runtime PM), and since it's architecture
specific it should _never_ be touched by device driver code. Exactly
like struct dev_archdata but for platform devices.

Like I said, we _could_ use struct device for this purpose, but it
sounds like suboptimal software design to me. Using struct device
means that we put data where it doesn't belong. I'd like to add
_platform_ _device_ _specific_ data, not data that should be present
in all struct devices in the system but only used in some cases.

Cheers,

/ magnus
