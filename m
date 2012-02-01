From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC PATCH 2/2] thermal: Add generic cpu cooling implementation
Date: Wed, 1 Feb 2012 14:57:07 +0000
Message-ID: <20120201145707.GD30184@srcf.ucam.org>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
 <1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323789196-4942-3-git-send-email-amit.kachhap@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 13, 2011 at 08:43:16PM +0530, Amit Daniel Kachhap wrote:
> This patch adds support for generic cpu thermal cooling low level
> implementations using frequency scaling and cpuhotplugg currently.

We've been over this kind of thing in the past. cpu hotplug is a 
relatively expensive operation, so people have previously been 
enthusiastic about using the scheduler to simply avoid running anything 
on CPUs if they're overheating. Has any general consensus been reached 
on this?

I'm also not entirely thrilled at now having two ways to manage the cpu 
through the thermal layer. ACPI already plugs in via the passive trip 
points. If we're going to do this then I'd like to see the ACPI code 
merged in with the generic cpu cooling code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
