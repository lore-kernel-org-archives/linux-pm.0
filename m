From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Wed, 28 Dec 2016 10:47:05 -0800
Message-ID: <20161228104705.57b101d3@jacob-builder>
References: <838trb233m.fsf@echidna.jochen.org>
        <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
        <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
        <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
        <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
        <83ful9yue7.fsf@echidna.jochen.org>
        <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
        <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62820 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751446AbcL1SqC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Dec 2016 13:46:02 -0500
In-Reply-To: <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Gerris <vgerris@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Jochen Hein <jochen@jochen.org>, Linux PM <linux-pm@vger.kernel.org>, jacob.jun.pan@linux.intel.com

On Wed, 28 Dec 2016 13:56:25 +0100
Vincent Gerris <vgerris@gmail.com> wrote:

> > >> If the right strategy were to disable C6 for all of BYT, then the
> > >> right implementation
> > >> would be to delete those states from byt_cstates[], rather than
> > >> for a routine to mark
> > >> them as disabled.  Note that a user can not later enable a state
> > >> that is marked as disabled here, it is never registered with
> > >> cpuidle, and thus the effect is exactly the same as if the entry
> > >> were never in the table in the first place.  
> I don't fully grasp this, but if the errata causes this, wouldn't it
> be more transparent to mark it as such so disable it?
> Are we really sure the errata does not cause this? If so, is there a
> recommended way from intel on how to patch this?
I don't think the EOI errata is relevant to this issue. As Len pointed
out, it is impossible to enter C6 or run idle task during ISR.

However, this errata might be the cause of the issue you seen, as you
mentioned you encounter the issue while playing media with audio i
presume? While I am looking for a fix, could you try without audio see
if it still hangs?

"VLP70. LPE Audio Playback May Result in System Hang
Problem: Extended audio playback with the LPE (Low Power Engine) may
result in a system hang if the SOC concurrently enters C6 or deeper
sleep states. Implication: The system may hang when this erratum occurs.
Workaround: It is possible for the driver to contain a workaround for
this erratum."
