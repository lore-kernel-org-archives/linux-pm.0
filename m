From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: return the exit status of a command
Date: Tue, 19 Mar 2019 08:12:25 -0700
Message-ID: <CAJvTdKnzLgx35KSxaZQt+YnTqSHZAX_maNu2D0R9ds8xYwW6NA@mail.gmail.com>
References: <1549982079-23516-1-git-send-email-darcari@redhat.com> <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365e035-3218-aff5-6d86-05215ce25073@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Arcari <darcari@redhat.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Jirka Hladky <jhladky@redhat.com>, linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
List-Id: linux-pm@vger.kernel.org

Acked-by: Len Brown <len.brown@intel.com>

On Wed, Feb 20, 2019 at 5:55 AM David Arcari <darcari@redhat.com> wrote:
>
>
> ping -- just want to make sure this doesn't get lost.
>
> Thanks!
>
> On 02/12/2019 09:34 AM, David Arcari wrote:
> > turbostat failed to return a non-zero exit status even though the
> > supplied command (turbostat <command>) failed.  Currently when turbostat
> > forks a command it returns zero instead of the actual exit status of the
> > command.  Modify the code to return the exit status.
> >
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Jirka Hladky <jhladky@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> > index 9327c0d..c3fad06 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -5077,6 +5077,9 @@ int fork_it(char **argv)
> >               signal(SIGQUIT, SIG_IGN);
> >               if (waitpid(child_pid, &status, 0) == -1)
> >                       err(status, "waitpid");
> > +
> > +             if (WIFEXITED(status))
> > +                     status = WEXITSTATUS(status);
> >       }
> >       /*
> >        * n.b. fork_it() does not check for errors from for_all_cpus()
> >
>


-- 
Len Brown, Intel Open Source Technology Center
