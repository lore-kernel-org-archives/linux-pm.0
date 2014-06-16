From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 14:04:13 +0200
Message-ID: <8738f53vsy.fsf@nemi.mork.no>
References: <87egyp8f70.fsf@nemi.mork.no> <87r42p146p.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:40187 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbaFPMEy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 08:04:54 -0400
In-Reply-To: <87r42p146p.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Mon, 16
	Jun 2014 13:31:26 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Bj=C3=B8rn Mork <bjorn@mork.no> writes:

> So the problem is related to runtime suspend before first use. I
> strongly suspect=20
>
>  aae4518b3124 PM / sleep: Mechanism to avoid resuming runtime-suspend=
ed devices unnecessarily

Nope, that was not it. So if blind guessing isn't going to work, then I
guess there is no way around a bisect :-)


Bj=C3=B8rn
