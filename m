From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] tools/power/x86/intel_pstate_tracer: Adjust directory ownership
Date: Tue, 18 Apr 2017 15:58:56 +0200
Message-ID: <2212263.ev98xHHkdz@aspire.rjw.lan>
References: <1492474333-8356-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59728 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753466AbdDROFA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 10:05:00 -0400
In-Reply-To: <1492474333-8356-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>, srinivas.pandruvada@linux.intel.com
Cc: len.brown@intel.com, dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, April 17, 2017 05:12:13 PM Doug Smythies wrote:
> The intel_pstate_tracer.py script only needs to be run as root
> when it is also used to actually acquire the trace data that
> it will post process. Otherwise it is generally preferable
> that it be run as a regular user.
> If run the first time as root the results directory will be
> incorrect for any subsequent run as a regular user. For any run
> as root the specific testname subdirectory will not allow any
> subsequent file saves by a regular user. Typically, and for example,
> the regular user might be attempting to save a .csv file converted to
> a spreadsheet with added calculations or graphs.
> 
> Set the directories and files owner and groups IDs to be the regular
> user, if required.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

Srinivas, any concerns?

> ---
>  .../x86/intel_pstate_tracer/intel_pstate_tracer.py      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index fd706ac..0b24dd9 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -353,6 +353,14 @@ def split_csv():
>                  os.system('grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
>                  os.system('grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
>  
> +def fix_ownership(path):
> +    """Change the owner of the file to SUDO_UID, if required"""
> +
> +    uid = os.environ.get('SUDO_UID')
> +    gid = os.environ.get('SUDO_GID')
> +    if uid is not None:
> +        os.chown(path, int(uid), int(gid))
> +
>  def cleanup_data_files():
>      """ clean up existing data files """
>  
> @@ -518,12 +526,16 @@ else:
>  
>  if not os.path.exists('results'):
>      os.mkdir('results')
> +    # The regular user needs to own the directory, not root.
> +    fix_ownership('results')
>  
>  os.chdir('results')
>  if os.path.exists(testname):
>      print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
>      sys.exit()
>  os.mkdir(testname)
> +# The regular user needs to own the directory, not root.
> +fix_ownership(testname)
>  os.chdir(testname)
>  
>  # Temporary (or perhaps not)
> @@ -566,4 +578,9 @@ plot_scaled_cpu()
>  plot_boost_cpu()
>  plot_ghz_cpu()
>  
> +# It is preferrable, but not necessary, that the regular user owns the files, not root.
> +for root, dirs, files in os.walk('.'):
> +    for f in files:
> +        fix_ownership(f)
> +
>  os.chdir('../../')
> 
