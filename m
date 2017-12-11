From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] PM / core: Use dev_pm_skip_next_resume_phases() internally
Date: Mon, 11 Dec 2017 11:30:09 +0100
Message-ID: <CAPDyKFpD8N6tfHJgkRWLgBugBOmoZepF23tcBy-1G4Crndi4sA@mail.gmail.com>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan> <2984032.oZIAi2Obeo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2984032.oZIAi2Obeo@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 10 December 2017 at 00:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the PM core call dev_pm_skip_next_resume_phases() to skip the
> "early resume" and "resume" phases of system-wide transitions to the
> working state for a given device instead of clearing the relevant
> status bits for it directly.
>
> No intentional changes in functionality.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
