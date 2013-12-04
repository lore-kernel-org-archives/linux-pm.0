From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 4/4] mvebu: Dove: Add clocks and DFS interrupt to
 cpu node in DT.
Date: Wed, 4 Dec 2013 14:55:11 +0000
Message-ID: <20131204145511.GE29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-5-git-send-email-andrew@lunn.ch>
 <20131204143921.GC29200@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47817 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932178Ab3LDOzi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 09:55:38 -0500
Content-Disposition: inline
In-Reply-To: <20131204143921.GC29200@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Dec 04, 2013 at 02:39:21PM +0000, Mark Rutland wrote:
> Is ddrclk actually fed into the CPU? Given that you seem to have an
> external L2 I don't see why the CPU would need the DDR clock.

I see from the other patches that it's simply a misleading name. Sorry
for the noise.

Mark.
