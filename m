From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Free the trace
 buffer memory
Date: Fri, 5 Jan 2018 23:54:24 +0100
Message-ID: <CAJZ5v0hvFrfRR8PEQgUgEh3r1NnH5r26fxzc=Kc+k9D8rDp+Lw@mail.gmail.com>
References: <1515191476-3424-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39239 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbeAEWyZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 17:54:25 -0500
In-Reply-To: <1515191476-3424-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Fri, Jan 5, 2018 at 11:31 PM, Doug Smythies <doug.smythies@gmail.com> wrote:
> The trace buffer memory should be, mostly, freed after
> the buffer has been output.
>
> This patch is required before a future patch that will allow
> the user to override the default, and specify the trace buffer
> memory allocation as a command line option.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

Looks OK to me.  Srinivas?

> ---
>  .../power/x86/intel_pstate_tracer/intel_pstate_tracer.py  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 0b24dd9..29f50d4 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -411,6 +411,16 @@ def set_trace_buffer_size():
>          print('IO error setting trace buffer size ')
>          quit()
>
> +def free_trace_buffer():
> +    """ Free the trace buffer memory """
> +
> +    try:
> +       open('/sys/kernel/debug/tracing/buffer_size_kb'
> +                 , 'w').write("1")
> +    except:
> +        print('IO error setting trace buffer size ')
> +        quit()
> +
>  def read_trace_data(filename):
>      """ Read and parse trace data """
>
> @@ -583,4 +593,9 @@ for root, dirs, files in os.walk('.'):
>      for f in files:
>          fix_ownership(f)
>
> +clear_trace_file()
> +# Free the memory
> +if interval:
> +    free_trace_buffer()
> +
>  os.chdir('../../')
> --
> 2.7.4
>
