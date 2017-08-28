From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] PM: docs: Describe high-level PM strategies and sleep states
Date: Mon, 28 Aug 2017 23:16:23 +0200
Message-ID: <3044110.ihmCmInn9X@aspire.rjw.lan>
References: <3053012.25nKXRPPaK@aspire.rjw.lan> <2269280.4Jsh6Gf7ai@aspire.rjw.lan> <7050738.DjM4u897mT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7050738.DjM4u897mT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, Markus Heiser <markus.heiser@darmarit.de>
List-Id: linux-pm@vger.kernel.org

On Monday, August 21, 2017 3:14:56 PM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reorganize the power management part of admin-guide by adding a
> description of major power management strategies supported by the
> kernel (system-wide and working-state power management) to it and
> dividing the rest of the material into the system-wide PM and
> working-state PM chapters.
> 
> On top of that, add a description of system sleep states to the
> system-wide PM chapter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> 
> -> v2:
>  - Changed the wording in the strategies.rst document slightly
>    to address Lukas' comments.
>  - Changed refs in the sleep-states.rst document to address
>    Markus' comments.
>  - Followed Markus' suggestion to drop C&P 'only' blocks in a few
>    places.
>  - Added Reviewed-by from Lukas as the changes to the content are
>    very small.
> 

I haven't seen any more comments on this which I'm taking as the lack of
objections, so I'm going to queue it up for 4.14.

Thanks,
Rafael
