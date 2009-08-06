From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] PM: Add convenience macro to make switching
	to dev_pm_ops less error-prone
Date: Thu, 6 Aug 2009 22:10:57 +0900
Message-ID: <aec7e5c30908060610l7edab1c1oae08720a675937a9@mail.gmail.com>
References: <20090803163304.GF5002@laptop> <200908052330.08452.rjw@sisk.pl>
	<20090806085144.GS13236@buzzloop.caiaq.de>
	<200908061416.08564.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908061416.08564.rjw@sisk.pl>
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
Cc: Daniel Mack <daniel@caiaq.de>, Frans Pop <elendil@planet.nl>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, pHilipp Zabel <philipp.zabel@gmail.com>, linux-pm@lists.linux-foundation.org, albin.tonnerre@free-electrons.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 6, 2009 at 9:16 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Thursday 06 August 2009, Daniel Mack wrote:
>> When is a good point to resend patches that use this macro? I guess they
>> won't make it to .31 anyway, right? So I just wait for the next merge
>> window?
>
> Yes, I think that would be the right thing to do.

Is it a good idea to disable the warning before the final 2.6.31 release?

Cheers,

/ magnus
