From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] cpufreq: Reformat printk() statements
Date: Tue, 11 Mar 2014 10:15:02 -0700
Message-ID: <c05f44ed-dff6-45b6-96eb-3f4e37ffee9b@CH1EHSMHS035.ehs.local>
References: <1394557380-15054-1-git-send-email-soren.brinkmann@xilinx.com>
 <531F441C.5070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:47946
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752325AbaCKRPM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Mar 2014 13:15:12 -0400
Content-Disposition: inline
In-Reply-To: <531F441C.5070107@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joe Perches <joe@perches.com>, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 2014-03-11 at 10:13AM -0700, Dirk Brandewie wrote:
> On 03/11/2014 10:03 AM, Soren Brinkmann wrote:
> >From: Joe Perches <joe@perches.com>
> >
> >  - Add missing newlines
> >  - Coalesce format fragments
> >  - Convert printks to pr_<level>
> >  - Align arguments
> >
>=20
> This introduces a bunch of lines over 80 charaters long.

Right, intentionally. It is more important to be able to grep for
printed messages than staying within 80 chars. That was the reason to
create this patch in the first place (I probably should have left that
note in the commit message).

	S=C3=B6ren


