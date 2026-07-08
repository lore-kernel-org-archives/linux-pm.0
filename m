Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C2346E7A;
	Wed,  8 Jul 2026 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553594; cv=none; b=XR/yPPSLvw6jlqfFnJlytY0MqHAaXcZ+7yV0VhdpVHOAmugitr6jG4a6KJxd4d4O5e0d8dM0C9CeQBCgU79/sXFCuAfoPefUt6MNxJTTW3bsZpXTXeZuXkmHNhnRXlg8lXjN9xk5wWfPbwmtB/vANQQbdTHXudCVQNDYFxsCNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553594; c=relaxed/simple;
	bh=LDCyPMgicCdip5qtyME6CtGqMfz7kPU+tZVSy1F60YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X9GlwqKdAD//TBAlkVgIMHhqcKHA93qxdZ5eXMF2LyMS5Da88mlXuHf5GnOgOF76efuGutETDCAMKmsO+vpGXcOKStltVq09YggOZxJ/z8wwKRwUfU3wZqQrx97OWA94OHkQ8gccnFeqol151cqDY2UJqLVJurV5aX/tw33kIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBoMfDbn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBoMfDbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783553593; x=1815089593;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LDCyPMgicCdip5qtyME6CtGqMfz7kPU+tZVSy1F60YY=;
  b=fBoMfDbnFRJNbWUAReRu3oQbrLx4wwImS7VCdLLRuHO6Kao6lLw8VG8t
   a82DhG39g/0cyHbdlKNLwC7IIRAY0JHZbObwPUedRQMV8AEo1RAYHMh87
   uelCg3CsUCNJAAeFgYqpxljNHmYvm7K0ofCPIwWA8Qqtsh0oqIsaYcaTO
   bpQzu+tN18mIGZMMRAH3l3YD+q+CDta0vjmki8O0V/7VuHrh2MsvBHpQu
   A1nyrV4/skLQzKbfiQqfJsdfPfK/bYZbNEGMNh53sxExgSoQ4M/UCR5BY
   8J/tRLjbV7s48XN58Y+vQ8KaXxqVxtjwytX0AuWGMp52z46VXCLEit5Hm
   w==;
X-CSE-ConnectionGUID: 0ZTRkzqgR7qINdS5Eb6lXw==
X-CSE-MsgGUID: nwdciWC8R5OQ0xu5iQ3ztg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101656392"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101656392"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:33:12 -0700
X-CSE-ConnectionGUID: tBEUYxsyT625J0IpfiWBcA==
X-CSE-MsgGUID: 6vp6bfZCSMC4pPUzoAW8BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256330737"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.110]) ([10.125.111.110])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:33:12 -0700
Message-ID: <31f103769bc42ad4ab03aea7131fc6d3ceb248d5.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power: intel_pstate_tracer: avoid optional
 imports for help
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, Len Brown <lenb@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Jul 2026 16:33:11 -0700
In-Reply-To: <20260624122747.5418-1-alhouseenyousef@gmail.com>
References: <20260624122747.5418-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-24 at 14:27 +0200, Yousef Alhouseen wrote:
> intel_pstate_tracer imports Gnuplot and numpy before parsing command-
> line
> options. As a result, even "-h" fails if those optional runtime
> modules are
> not installed.
>=20
> Move the imports to the paths that need them. This lets the help and
> invalid-argument paths describe usage without requiring plotting/data
> dependencies. While there, fix a typo in the help text and matching
> comments.
>=20
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../intel_pstate_tracer/intel_pstate_tracer.py | 18 ++++++++++-----=
-
> --
> =C2=A01 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git
> a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 38cfbdcde..64001bc80 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -32,8 +32,6 @@ import re
> =C2=A0import signal
> =C2=A0import sys
> =C2=A0import getopt
> -import Gnuplot
> -from numpy import *
> =C2=A0from decimal import *
> =C2=A0
> =C2=A0__author__ =3D "Srinivas Pandruvada"
> @@ -88,8 +86,8 @@ def print_help(driver_name):
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbytes: Ki=
lo bytes of memory per CPU to allocate to
> the trace buffer. Default: 10240')
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0 Output:')
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0 If not already present=
, creates a "results/test_name"
> folder in the current working directory with:')
> -=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu.csv - comma=
 seperated values file with trace
> contents and some additional calculations.')
> -=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu???.csv - co=
mma seperated values file for CPU
> number ???.')
> +=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu.csv - comma=
 separated values file with trace
> contents and some additional calculations.')
> +=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu???.csv - co=
mma separated values file for CPU
> number ???.')
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *.png - a =
variety of PNG format plot files created
> from the trace contents and the additional calculations.')
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0 Notes:')
> =C2=A0=C2=A0=C2=A0=C2=A0 print('=C2=A0=C2=A0=C2=A0 Avoid the use of _ (un=
derscore) in test names,
> because in gnuplot it is a subscript directive.')
> @@ -295,6 +293,8 @@ def common_all_gnuplot_settings(output_png):
> =C2=A0def common_gnuplot_settings():
> =C2=A0=C2=A0=C2=A0=C2=A0 """ common gnuplot settings. """
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 import Gnuplot
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 g_plot =3D Gnuplot.Gnuplot(persist=3D1)
> =C2=A0#=C2=A0=C2=A0 The following line is for rigor only. It seems to be =
assumed for
> .csv files
> =C2=A0=C2=A0=C2=A0=C2=A0 g_plot('set datafile separator \",\"')
> @@ -343,7 +343,7 @@ def store_csv(cpu_int, time_pre_dec,
> time_post_dec, core_busy, scaled, _from, _t
> =C2=A0=C2=A0=C2=A0=C2=A0 graph_data_present =3D True;
> =C2=A0
> =C2=A0def split_csv(current_max_cpu, cpu_mask):
> -=C2=A0=C2=A0=C2=A0 """ seperate the all csv file into per CPU csv files.=
 """
> +=C2=A0=C2=A0=C2=A0 """ separate the main csv file into per CPU csv files=
. """
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if os.path.exists('cpu.csv'):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for index in range(0, cu=
rrent_max_cpu + 1):
> @@ -482,7 +482,7 @@ def read_trace_data(filename, cpu_mask):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if cpu_int > current_max_cpu:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 current_max_cpu =3D cpu_int
> =C2=A0# End of for each trace line loop
> -# Now seperate the main overall csv file into per CPU csv files.
> +# Now separate the main overall csv file into per CPU csv files.
> =C2=A0=C2=A0=C2=A0=C2=A0 split_csv(current_max_cpu, cpu_mask)
> =C2=A0
> =C2=A0def signal_handler(signal, frame):
> @@ -508,8 +508,6 @@ if __name__ =3D=3D "__main__":
> =C2=A0=C2=A0=C2=A0=C2=A0 valid1 =3D False
> =C2=A0=C2=A0=C2=A0=C2=A0 valid2 =3D False
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts, args =3D
> getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=3D","inter
> val=3D","cpu=3D","name=3D","memory=3D"])
> =C2=A0=C2=A0=C2=A0=C2=A0 except getopt.GetoptError:
> @@ -538,6 +536,10 @@ if __name__ =3D=3D "__main__":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_help('intel_pstate=
')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.exit()
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 from numpy import zeros
> +
> +=C2=A0=C2=A0=C2=A0 cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if cpu_list:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for p in re.split("[,]",=
 cpu_list):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if int(p) < MAX_CPUS :
