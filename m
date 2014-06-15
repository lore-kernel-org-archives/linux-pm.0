From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] intel_pstate: Correct rounding in busy calculation
Date: Mon, 16 Jun 2014 00:46:07 +0200
Message-ID: <3580748.fHY7I4AV1p@vostro.rjw.lan>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com> <1401381145-17745-3-git-send-email-dirk.j.brandewie@intel.com> <000601cf88a8$5bac8570$13059050$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <000601cf88a8$5bac8570$13059050$@net>
Sender: stable-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: dirk.brandewie@gmail.com, linux-pm@vger.kernel.org, 'Dirk Brandewie' <dirk.j.brandewie@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 15, 2014 07:44:47 AM Doug Smythies wrote:
> On 2014.05.29 09:32 Dirk Brandewie wrote:
> 
> There is a mistake in this patch.
> Even though the patch is from Dirk, the mistake is my fault, sorry.
> 
> Severity: Not very serious, but can increase target pstate by one extra value.
> For real world work flows the issue should self correct (but I have no proof).
> It is the equivalent of different PID gains for positive and negative numbers.
> 
> Why this e-mail? Why not just submit a patch?
> Because I do not yet know how, particularly for v3.16

Quite straightforward.  Create a patch with a changelog saying that it
fixes a bug, put the hash and subject of the commit that introduced
the bug in that changelog and send it to linux-pm@vger.kernel.org with
a CC to me (preferably at rjw@rjwysocki.net, but you can also use
rafael@kernel.org if you like).  I will take care of the patch from
that point on.

Rafael
