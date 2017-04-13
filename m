From: <Mario.Limonciello@dell.com>
Subject: RE: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 20:38:28 +0000
Message-ID: <e50750499ea246d78b336caae95d36b8@ausx13mpc120.AMER.DELL.COM>
References: <20170412230854.GA11963@fury> <20170413073339.GH3090@pali>
 <20170413165646.GD2064@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:4957 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751492AbdDMUib (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 16:38:31 -0400
In-Reply-To: <20170413165646.GD2064@fury>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: dvhart@infradead.org, pali.rohar@gmail.com
Cc: rjw@rjwysocki.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

Earlier question from Andy.  I had some discussion with the right people ab=
out this.

> Is it just the "call SMBIOS" GUID or are there other things?

Today - it's just the SMBIOS calling GUID.  There are plans (not yet concre=
te) for
splitting up data access and organization of that data access classes acros=
s multiple=20
 other GUID/method pairs in the future.

Ideally this could be done without needing kernel patches every time a new =
GUID
would (essentially) need to be whitelisted.

> I am a strong supporter of the following philosophy with respect to suppo=
rting
> innovation:
> "Enable them to enable themselves and get out of their way"
>=20
> I've followed this approach over the years to encourage upstream first so=
ftware
> development, open-first policy toward specifications and documentation, p=
roper
> license selection, and development of new mechanisms in existing standard=
s, like
> ACPI _DSD. All of these serve to support innovation by removing bottlenec=
ks and
> enabling developers to be independent.
>=20
> What I don't want to see is the Linux kernel becoming a bottleneck to fea=
ture
> parity with Windows (or to becoming the lead vehicle for new features). W=
hen a
> vendor has a feature they want to expose which they determine to be a val=
ue
> proposition for their product, I don't want the lack of a class driver to=
 get in
> the way. Exposing specific GUIDs is a minimal and easy to upstream change=
 which
> would enable rapid feature enabling.
>=20
> Perhaps I should have led with this :-)
>=20

So considering future plans, I'd really like if it's possible to expose all=
 the GUID's the
GUID's the same as Windows does today.

As example is we have some diagnostic testing tools.  Having to whitelist i=
nterfaces
for them to operate would be sub-optimal.
