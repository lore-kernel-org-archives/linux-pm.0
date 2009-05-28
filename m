From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Thu, 28 May 2009 15:02:20 +0900
Message-ID: <aec7e5c30905272302w1539fd22sf38e4f513f2d3247__31917.7948906601$1243490599$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527121042.GD1970@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527121042.GD1970@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de, paul@pwsan.com, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 27, 2009 at 9:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 27, 2009 at 07:06:25PM +0900, Magnus Damm wrote:
>
>> These patches extend platform device and driver interfaces to
>> allow architectures to implement platform device runtime pm.
>
>> Have a look at the last patch for a SuperH mockup that shows how
>> it all fits together. We need this or a similar interface to be able
>> to enter deep sleep states on SuperH. I believe other architectures
>> have similar requirements.
>
> ARM definitely does. =A0The OMAP SoCs are probably furthest along in
> software support for this sort of functionality but it's pretty much
> standard for modern ARMs. =A0I'd CC in the ARM list but it's subscribers
> only, though the OMAP folks are also over on linux-omap@vger.kernel.org
> which isn't.

I'll include linux-omap next time. Thanks for your suggestion!

/ magnus
