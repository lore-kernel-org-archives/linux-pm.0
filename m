From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86: PM: Make APM idle driver initialize polling state
Date: Wed, 07 Feb 2018 10:20:58 +0100
Message-ID: <1595367.GFL0qxR379@aspire.rjw.lan>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com> <1862424.1bTBpgPzTf@aspire.rjw.lan> <20180206182617.GQ5453@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180206182617.GQ5453@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 6, 2018 7:26:17 PM CET Ville Syrjälä wrote:
> On Tue, Feb 06, 2018 at 07:02:58PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
> > drivers initialize polling state) to initialize the polling state like
> > the other cpuidle drivers modified by that commit to prevent cpuidle
> > from crashing.
> > 
> > Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
> > Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> And maybe?
> 
> Cc: <stable@vger.kernel.org> # v4.14+

I add these when applying patches.

Actually, I've queued up the patch with this tag already.
