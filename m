From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 6/8] Documentation: fix ref to power basic-pm-debugging
Date: Thu, 12 Oct 2017 22:46:53 +0200
Message-ID: <CAJZ5v0juGZtK3ODeSXwDY1DuOUo-8MibkUq0usB05G6ii4macw@mail.gmail.com>
References: <cover.1507838726.git.tom.saeger@oracle.com> <60409ff12ddfbb1e188215981ff0b5f0315fb4b5.1507838726.git.tom.saeger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <60409ff12ddfbb1e188215981ff0b5f0315fb4b5.1507838726.git.tom.saeger@oracle.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tom Saeger <tom.saeger@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 12, 2017 at 10:24 PM, Tom Saeger <tom.saeger@oracle.com> wrote:
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  Documentation/power/interface.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/power/interface.txt b/Documentation/power/interface.txt
> index 7dc75f48e8bd..27df7f98668a 100644
> --- a/Documentation/power/interface.txt
> +++ b/Documentation/power/interface.txt
> @@ -43,7 +43,7 @@ The currently selected option is printed in square brackets.
>  The 'platform' option is only available if the platform provides a special
>  mechanism to put the system to sleep after creating a hibernation image (ACPI
>  does that, for example).  The 'suspend' option is available if Suspend-to-RAM
> -is supported.  Refer to Documentation/power/basic_pm_debugging.txt for the
> +is supported.  Refer to Documentation/power/basic-pm-debugging.txt for the
>  description of the 'test_resume' option.
>
>  To select an option, write the string representing it to /sys/power/disk.
> --

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
