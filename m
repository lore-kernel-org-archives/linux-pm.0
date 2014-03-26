From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 00/14] CPU idle for Armada XP
Date: Tue, 25 Mar 2014 20:42:23 -0400
Message-ID: <20140326004223.GL28304@titan.lakedaemon.net>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Gregory,

On Tue, Mar 25, 2014 at 11:48:11PM +0100, Gregory CLEMENT wrote:
...
> The first patch should go through ARM subsystem and should be taken by
> Russell King. I made few change on it following Lorenzo advice and
> now it will reuse the cpu v7 suspend and resume function and just do
> specific operation before calling them.
> 
> The 13th patch 'cpuidle: mvebu: Add initial cpu idle support for
> Armada 370/XP SoC' is the only one who should go to the cpuidle
> subsystem. But of course I would like that Daniel Lezcano or Rafael
> J. Wysocki have a look on the whole series and especially patches 10,
> 12 and 14.

Ok, I'm tired.  :)  Help me out here.  Patches 1 and 13 are depended on
by the other patches and vice-versa, right?  In that case, I'm thinking
it's best to seek Acks from the other maintainers and keep the whole
branch together.  Please tell me if I'm wrong.

thx,

Jason.
