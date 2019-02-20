From: David Arcari <darcari@redhat.com>
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a
 command
Date: Wed, 20 Feb 2019 08:55:31 -0500
Message-ID: <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
References: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549982079-23516-1-git-send-email-darcari@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Jirka Hladky <jhladky@redhat.com>, linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
List-Id: linux-pm@vger.kernel.org


ping -- just want to make sure this doesn't get lost.

Thanks!

On 02/12/2019 09:34 AM, David Arcari wrote:
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
