From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/3] PM: make VT switching to the suspend console
 optional v3
Date: Tue, 5 Feb 2013 13:55:44 +0000
Message-ID: <20130205135544.6adab270@jbarnes-t420>
References: <1359985042-2610-1-git-send-email-jbarnes@virtuousgeek.org>
	<1452100.EKe1it2LWl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from oproxy11-pub.bluehost.com ([173.254.64.10]:50591 "HELO
	oproxy11-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754785Ab3BEN4H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 08:56:07 -0500
In-Reply-To: <1452100.EKe1it2LWl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org

On Mon, 04 Feb 2013 21:26:26 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday, February 04, 2013 01:37:20 PM Jesse Barnes wrote:
> > KMS drivers can potentially restore the display configuration without
> > userspace help.  Such drivers can can call a new funciton,
> > pm_vt_switch_required(false) if they support this feature.  In that
> > case, the PM layer won't VT switch to the suspend console at suspend
> > time and then back to the original VT on resume, but rather leave things
> > alone for a nicer looking suspend and resume sequence.
> > 
> > v2: make a function so we can handle multiple drivers (Alan)
> > v3: use a list to track device requests (Rafael)
> > 
> > Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for all [1-3/3].

Any chance for an r-b on the PM one at least?  Then Daniel could
probably push this through drm-intel-next.

Thanks,
Jesse
