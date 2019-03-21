From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a command
Date: Fri, 22 Mar 2019 00:26:18 +0100
Message-ID: <1920733.IGH1RQtUIy@aspire.rjw.lan>
References: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Jirka Hladky <jhladky@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 12, 2019 3:34:39 PM CET David Arcari wrote:
> turbostat failed to return a non-zero exit status even though the
> supplied command (turbostat <command>) failed.  Currently when turbostat
> forks a command it returns zero instead of the actual exit status of the
> command.  Modify the code to return the exit status.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Jirka Hladky <jhladky@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/power/x86/turbostat/turbostat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 9327c0d..c3fad06 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -5077,6 +5077,9 @@ int fork_it(char **argv)
>  		signal(SIGQUIT, SIG_IGN);
>  		if (waitpid(child_pid, &status, 0) == -1)
>  			err(status, "waitpid");
> +
> +		if (WIFEXITED(status))
> +			status = WEXITSTATUS(status);
>  	}
>  	/*
>  	 * n.b. fork_it() does not check for errors from for_all_cpus()
> 

Applied, thanks!
