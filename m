From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] PM / AVS changes for v3.18 - v2
Date: Fri, 26 Sep 2014 07:23:21 -0700
Message-ID: <7hmw9m795y.fsf@deeprootsystems.com>
References: <7ha95nikqh.fsf@linaro.org> <20140926081534.GA27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34913 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166AbaIZOXX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Sep 2014 10:23:23 -0400
In-Reply-To: <20140926081534.GA27755@sirena.org.uk> (Mark Brown's message of
	"Fri, 26 Sep 2014 09:15:34 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, dianders@chromium.org, heiko@sntech.de

Mark Brown <broonie@kernel.org> writes:

> On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:
>
>> The first pull request was missing a dependency on a feature that went
>> in through Mark Brown's regulator tree, so it wouldn't actually compile
>> properly by itself.  This version pulls in that topic branch from Marks
>> tree (topic/voltage-ev branch, already part of -next), and now compiles fine.
>
> Please in future don't pull anything in from my tree without a signed
> tag (speak to me if there isn't one).

Sorry about that.

Had there been more than one patch in this topic branch, or it wasn't
based directly on an -rc tag, I would've waited for confirmation about
it being stable, but since it was a single patch, based directly on an
-rc tag, I assumed it was stable.

In the future, I'll be sure to request a signed tag.

Kevin
