Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB314749D1
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784736122; cv=none; b=gLXf49ANvR0vdYMa2J56NyinR9g+RM/aeJ1GQW8sLV9FX5GrO1y+jnhGBV1E/AcFWWhpYRMOHO8MN7PZW/9cC4Hi7f8ZMO/NaRjWo6SgDUuZBy89f/ss1ddzFhpJsTqdb614QnaVWz0cjTGK9jBgbU+THf4tWva/d0bRVRp50HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784736122; c=relaxed/simple;
	bh=uH75007pzbG6vEhcvEo/qoov9cMFfPJPobKudXdCdgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/8+AmO+o9cmjmhURsBw+44eD2LCtrZ2X/JUo0vJZAlF7QzMH5YZIZyLEPmx+50QOnrNO13uaWPJcCOzI1dBJDfFJkE7QE0nfkqNshgtn1xCQPI1t/MVGdsTXGjtypHpYEOlHNsbVOP7lR5k9oQhMDa7H+P/GNts+p1tssFfUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heln2W2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heln2W2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A38E1F00A3A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784736121;
	bh=lhUvTbt9t3dMflaBKyF1NSYkPvp1/DelqmmbpEyB8n0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=heln2W2Gfopvq/Kq3PrBE+62jnxiLNViopZ7yfi5xpl4e4gxJsbirUtxhWO+wNu03
	 AmY0Bn/JzrhP7Rs5hOtVVgZA5mErz7URWhMucL/5q9LjNIRJbxgBy4rSPO3t+TvNRY
	 N86x6G/qqrwnIrpz1aMNWoQcuV1TGmaoZDaZALkbQD04C++ssRuOqE2/bYJtqdUkHe
	 EaorL/x+fSX+K9qzJHTvrNunY53M9592POu3mgWjTsWYwfZzcmBUXVeFfhAu2ZyFjW
	 P81DKOe2K4fHrcildz0qZuusCOPAeANfZsnb3Xn7L3oIghj14w5HkPxOY/c0xtDxBP
	 cKEn8saIvi1bw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b013084dc2so7958051e87.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 09:02:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOSJnLlsjuuMGW3oV1S+2qT5x/LfourbpkwoWUy4i0ltDnnuff
	tofdQGFIfF0vovdtC9589l4yr+QCOogsVVRR9wl+qsTsJbOOyunMsHE1riq02l/o+oKebqEYvR/
	bfLkGUVt7RiVU30BC3D5D12wqdetd2wQ=
X-Received: by 2002:a05:6512:a89:b0:5b0:e938:8f28 with SMTP id
 2adb3069b0e04-5b28f9a7cb5mr5257257e87.34.1784736119537; Wed, 22 Jul 2026
 09:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624122747.5418-1-alhouseenyousef@gmail.com> <31f103769bc42ad4ab03aea7131fc6d3ceb248d5.camel@linux.intel.com>
In-Reply-To: <31f103769bc42ad4ab03aea7131fc6d3ceb248d5.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 18:01:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i92qp86bY2k0GqP8YWx55Wi8y8Cascr8egWFRLkD=+DA@mail.gmail.com>
X-Gm-Features: AUfX_myftylHs2GQXP8UlLrP8SMrKw6R6vopjCO_sqD-S9eLJ2mY0xgCr9RNFr0
Message-ID: <CAJZ5v0i92qp86bY2k0GqP8YWx55Wi8y8Cascr8egWFRLkD=+DA@mail.gmail.com>
Subject: Re: [PATCH] tools/power: intel_pstate_tracer: avoid optional imports
 for help
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:33=E2=80=AFAM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2026-06-24 at 14:27 +0200, Yousef Alhouseen wrote:
> > intel_pstate_tracer imports Gnuplot and numpy before parsing command-
> > line
> > options. As a result, even "-h" fails if those optional runtime
> > modules are
> > not installed.
> >
> > Move the imports to the paths that need them. This lets the help and
> > invalid-argument paths describe usage without requiring plotting/data
> > dependencies. While there, fix a typo in the help text and matching
> > comments.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.3 material, thanks!

> > ---
> >  .../intel_pstate_tracer/intel_pstate_tracer.py | 18 ++++++++++------
> > --
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git
> > a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > index 38cfbdcde..64001bc80 100755
> > --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > @@ -32,8 +32,6 @@ import re
> >  import signal
> >  import sys
> >  import getopt
> > -import Gnuplot
> > -from numpy import *
> >  from decimal import *
> >
> >  __author__ =3D "Srinivas Pandruvada"
> > @@ -88,8 +86,8 @@ def print_help(driver_name):
> >      print('      kbytes: Kilo bytes of memory per CPU to allocate to
> > the trace buffer. Default: 10240')
> >      print('  Output:')
> >      print('    If not already present, creates a "results/test_name"
> > folder in the current working directory with:')
> > -    print('      cpu.csv - comma seperated values file with trace
> > contents and some additional calculations.')
> > -    print('      cpu???.csv - comma seperated values file for CPU
> > number ???.')
> > +    print('      cpu.csv - comma separated values file with trace
> > contents and some additional calculations.')
> > +    print('      cpu???.csv - comma separated values file for CPU
> > number ???.')
> >      print('      *.png - a variety of PNG format plot files created
> > from the trace contents and the additional calculations.')
> >      print('  Notes:')
> >      print('    Avoid the use of _ (underscore) in test names,
> > because in gnuplot it is a subscript directive.')
> > @@ -295,6 +293,8 @@ def common_all_gnuplot_settings(output_png):
> >  def common_gnuplot_settings():
> >      """ common gnuplot settings. """
> >
> > +    import Gnuplot
> > +
> >      g_plot =3D Gnuplot.Gnuplot(persist=3D1)
> >  #   The following line is for rigor only. It seems to be assumed for
> > .csv files
> >      g_plot('set datafile separator \",\"')
> > @@ -343,7 +343,7 @@ def store_csv(cpu_int, time_pre_dec,
> > time_post_dec, core_busy, scaled, _from, _t
> >      graph_data_present =3D True;
> >
> >  def split_csv(current_max_cpu, cpu_mask):
> > -    """ seperate the all csv file into per CPU csv files. """
> > +    """ separate the main csv file into per CPU csv files. """
> >
> >      if os.path.exists('cpu.csv'):
> >          for index in range(0, current_max_cpu + 1):
> > @@ -482,7 +482,7 @@ def read_trace_data(filename, cpu_mask):
> >              if cpu_int > current_max_cpu:
> >                  current_max_cpu =3D cpu_int
> >  # End of for each trace line loop
> > -# Now seperate the main overall csv file into per CPU csv files.
> > +# Now separate the main overall csv file into per CPU csv files.
> >      split_csv(current_max_cpu, cpu_mask)
> >
> >  def signal_handler(signal, frame):
> > @@ -508,8 +508,6 @@ if __name__ =3D=3D "__main__":
> >      valid1 =3D False
> >      valid2 =3D False
> >
> > -    cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> > -
> >      try:
> >          opts, args =3D
> > getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=3D","inter
> > val=3D","cpu=3D","name=3D","memory=3D"])
> >      except getopt.GetoptError:
> > @@ -538,6 +536,10 @@ if __name__ =3D=3D "__main__":
> >          print_help('intel_pstate')
> >          sys.exit()
> >
> > +    from numpy import zeros
> > +
> > +    cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> > +
> >      if cpu_list:
> >          for p in re.split("[,]", cpu_list):
> >              if int(p) < MAX_CPUS :
