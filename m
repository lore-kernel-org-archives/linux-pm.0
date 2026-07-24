Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7435DA78;
	Fri, 24 Jul 2026 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884405; cv=none; b=u+bQHGldSzbTeNV+9voHn7zS4PfpCbXWO21OChwOeWhUdUGf/LDjeMhgRVDo7Xso++llVYTkI3qZnzdhavtguWZlqE0MFOVVAbdbUeBS2l/saCeBgasMSy9YZSSi1wJjuX4mUSvn0iq2qQu7nakPg1j4nA2ci/O65rCPurO0m70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884405; c=relaxed/simple;
	bh=mJcDNw77NdyWtM53SGB/8AR4Gpz9ghClvL+bhScb5ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlwJY4GW4llPlNuG51UDo0Yd6RDkyG1k0ODVdarOtWYHHmB2Pz8sXPJSM/s0E+Wu+cju29hMzOfSH6qL+q6HjPq9y0Esj9UZVTExJ3Q5KHngj2kV1QDGhIoqDSNY4l0SWuE2/buMU3jvRmTjYasjrFL915ZJnD4N04Zg9B15Hqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYSga7au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYSga7au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEB31F000E9;
	Fri, 24 Jul 2026 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784884403;
	bh=3QK6gyQhkWOBgkpuC3mjUiU480nGefF4k15Ca4dUWf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cYSga7aular65dSj2MUbwJJ4DycAlyRInzXxeQ/YqUwi6f9mVMI4jJEoyKpKAG8g4
	 0cZRohe/QzecD4xIOQ1R1DiKtX340RgsKewYLH7FwuLKrq3boKRtx9chO2jsVYuU6E
	 f97HftXxecuOmj2bAR76lSrNcwd2b+utD+jEGySfx2skBX25S0P3aDXYf1gCLbOySt
	 bGEtHrhGhx9w39HvACO0OQi0UtrtiYC/jFgubYcydD19VSW2bU6Eqe/mVT6e13U2M3
	 NZY90qtmu4+lqI8epsob3yD66vUt7ofGh3Vyr2Nj7idC7lKWglcln+yxP4gteNTY6c
	 inSWay+JbEGNw==
Date: Fri, 24 Jul 2026 10:13:17 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] firmware: arm_scmi: Add SCMI QCOM Generic
 Extension Protocol documentation
Message-ID: <20260724-crouching-starfish-of-apotheosis-d1cdf8@sudeepholla>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
 <20260724-rfc_v8_scmi_memlat-v1-1-cb732bcff1f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-1-cb732bcff1f4@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 12:48:06PM +0530, Pragnesh Papaniya wrote:
> Add System Control Management Interface (SCMI) Qualcomm Generic Extension
> Protocol documentation. It consists of a small set of generic SET/GET/
> START/STOP commands, which is used to turn on/off and configure Qualcomm
> SoC specific algorithms that run on the SCP.
> 
> It currently only supports MEMLAT (memory latency governor) algorithm.
> The immutable pairing of the MEMLAT algorithm string with the supported
> param_ids associated with it are documented here.
> 
> Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
> ---
>  .../arm_scmi/vendors/qcom/qcom_generic.rst         | 954 +++++++++++++++++++++
>  1 file changed, 954 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
> new file mode 100644
> index 000000000000..42e327d53841
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
> @@ -0,0 +1,954 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +==================================================================================
> +System Control and Management Interface (SCMI) Qualcomm Generic Extension Protocol
> +==================================================================================
> +
> +:Copyright: |copy| Qualcomm Technologies, Inc. and/or its subsidiaries.
> +
> +:Authors:
> +   - Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> +   - Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
> +
> +System Control and Management Interface Qualcomm Generic Extension Vendor Protocol
> +==================================================================================
> +
> +System Control Management Interface (SCMI) Qualcomm Generic Extension Protocol
> +consists of a small set of generic SET/GET/START/STOP commands, which is used to
> +turn on/off and configure Qualcomm SoC specific algorithms that run on the SCP.
> +Each algorithm is identified through an algorithm string and has an immutable list
> +of param_ids. All supported algorithms (currently just MEMLAT) have their own
> +dedicated section and are listed after the generic commands.
> +

This multiplexer 'N' random algorithn into one single custom SCMI protocol ID
(0x80) seems to go against the general SCMI design principle and this seems
like a deliberated attempt to circumvent the standard SCMI protocol template.
Standard SCMI expects distinct features to occupy their own vendor protocol
IDs and utilize standard protocol discovery.

I have asked details of algorithm to be listed here atleast few times now
and has been constantly ignored. So don't complain if I start ignoring these
patches.

> +message_id: 0x1
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |See ARM SCMI Specification for status code definitions.    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |Bits[31:16] Reserved, must be set to 0.                    |
> +|                  |Bits[15:8] Number of agents in the system. Must match the  |
> +|                  |value reported by the standard BASE protocol's             |
> +|                  |PROTOCOL_ATTRIBUTES response.                              |


Please drop the above, duplication is always recipe for problems.

> +|                  |Bits[7:0] Number of algorithmic strings supported by the   |
> +|                  |system. Only "MEMLAT" is currently supported hence it      |
> +|                  |returns 1.                                                 |
> ++------------------+-----------------------------------------------------------+

OK, so this is the only algorithm.

> +
> +PROTOCOL_MESSAGE_ATTRIBUTES
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x2
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |See ARM SCMI Specification for status code definitions.    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 attributes |For all message IDs the parameter has a value of 0.        |
> ++------------------+-----------------------------------------------------------+
> +
> +QCOM_SCMI_SET_PARAM
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x10
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 ext_id     |Reserved, must be zero.                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
> +|                  |and is used to set various parameters supported by it.     |


This is too open and can soon become ambiguous. More description on what
exactly this token message id is a must. This is not like normal kernel
function to keep it this ambiguous, it is a firmware interface which is
comparable to the user ABI.

> ++------------------+-----------------------------------------------------------+
> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
> +|                  |algorithm string pair. The payload size depends on the     |
> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
> +|                  |sections below.                                            |


Ditto.

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
> +|                  |by the chosen algorithm string.                            |
> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
> +|                  |matches.                                                   |
> +|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
> +|                  |is rejected by the algorithm string.                       |
> ++------------------+-----------------------------------------------------------+
> +
> +QCOM_SCMI_GET_PARAM
> +~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x11
> +protocol_id: 0x80
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 ext_id     |Reserved, must be zero.                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |


At this point I start to think what is the point of exchanging the whole 8
byte string back and forth instead of simple ID.

> ++------------------+-----------------------------------------------------------+
> +|uint32 param_id   |Serves as the token message id for the algorithm string.   |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buf[]      |Serves as the payload and store of value for the specified |
> +|                  |param_id and algorithm string pair. The payload size       |
> +|                  |depends on the (algorithm string, param_id) pair; see the  |
> +|                  |per-algorithm sections below. The response payload is      |
> +|                  |returned in the same buffer, overwriting the request       |
> +|                  |contents on success.                                       |


Ditto as above(too ambiguous, gives no clue on what that is)

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
> +|                  |by the chosen algorithm string and the result is copied    |
> +|                  |into buf[].                                                |
> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
> +|                  |matches.                                                   |
> +|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
> +|                  |is rejected by the algorithm string.                       |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buf[]      |Holds the payload of the result of the query, returned in  |
> +|                  |the same buffer used to send the request. Size depends on  |
> +|                  |the (algorithm string, param_id) pair.                     |
> ++------------------+-----------------------------------------------------------+
> +
> +QCOM_SCMI_START_ACTIVITY
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x12
> +protocol_id: 0x80
> +
> +The activity to be started is defined by the algorithm string; see the
> +per-algorithm sections (e.g. MEMLAT_START_TIMER) for valid param_ids.
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 ext_id     |Reserved, must be zero.                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
> +|                  |and is generally used to start the activity performed by   |
> +|                  |the algorithm string.                                      |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
> +|                  |algorithm string pair. The payload size depends on the     |
> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
> +|                  |sections below.                                            |


Ditto

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the activity performed by the algorithm string |
> +|                  |starts successfully, or if it was already running.         |
> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
> +|                  |matches.                                                   |
> ++------------------+-----------------------------------------------------------+
> +
> +QCOM_SCMI_STOP_ACTIVITY
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +message_id: 0x13
> +protocol_id: 0x80
> +
> +The activity to be stopped is defined by the algorithm string; see the
> +per-algorithm sections (e.g. MEMLAT_STOP_TIMER) for valid param_ids.
> +
> ++------------------+-----------------------------------------------------------+
> +|Parameters                                                                    |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 ext_id     |Reserved, must be zero.                                    |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
> ++------------------+-----------------------------------------------------------+
> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
> +|                  |and is generally used to stop the activity performed by    |
> +|                  |the algorithm string.                                      |
> ++------------------+-----------------------------------------------------------+
> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
> +|                  |algorithm string pair. The payload size depends on the     |
> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
> +|                  |sections below.                                            |


Ditto

> ++------------------+-----------------------------------------------------------+
> +|Return values                                                                 |
> ++------------------+-----------------------------------------------------------+
> +|Name              |Description                                                |
> ++------------------+-----------------------------------------------------------+
> +|int32 status      |SUCCESS: if the activity performed by the algorithm string |
> +|                  |stops successfully, or if it was not running.              |
> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
> +|                  |matches.                                                   |
> ++------------------+-----------------------------------------------------------+
> +
> +MEMLAT: Memory Latency algorithm
> +________________________________
> +
> +The MEMLAT algorithm (0x4d454d4c4154, ASCII "MEMLAT") scales the DDR, LLCC and
> +DDR_QOS buses in response to memory-latency-bound workloads. It runs on the CPUCP:
> +every sampling window it reads the per-CPU AMU counters, derives its statistics
> +(instructions-per-miss, back-end stall, write-back ratio), maps that to a target
> +level and votes for it directly on the DDR/LLCC/DDR_QOS interconnect. The kernel
> +never issues a frequency request in that loop. The 6-byte value is treated as a
> +64-bit algorithm string and split into two uint32 fields on the wire: algo_low
> +carries its lower 32 bits and algo_high its upper 32 bits.
> +
> +With a distinct need to have the memory buses scaling done in SCP in response to
> +memory-latency-bound workloads, none of the existing SCMI solutions could be used
> +as-is. MPAM does not apply either: it is not enabled on all of the affected parts
> +(e.g. Hamoa). The role split between SCP and client driver is described next.
> +
> +MEMLAT client driver pseudo-code:
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. code-block:: text
> +
> +  probe():
> +    SET_COMMON_EV_MAP                          # AMU events (all groups)
> +    for each memory group (DDR / LLCC / DDR_QOS):
> +      SET_MEM_GROUP                            # bind group to interconnect
> +      SET_GRP_EV_MAP                           # per-group AMU events
> +      for each monitor in the group:
> +        SET_MONITOR                            # topology, cpumask, name
> +        IPM_CEIL / BE_STALL_FLOOR              # per-monitor tuneables
> +        MON_FREQ_MAP                           # cpufreq -> memfreq map
> +        SET_MIN_FREQ / SET_MAX_FREQ            # clamps
> +    SAMPLE_MS                                  # sampling period
> +    SET_EFFECTIVE_FREQ_METHOD                  # cpu-freq derivation method
> +    START_TIMER                                # CPUCP now scales autonomously
> +
> +  devfreq poll (twice per CPUCP sample period):
> +    GET_CUR_FREQ                               # read voted freq, per monitor
> +
> +  remove():
> +    STOP_TIMER
> +
> +SCP pseudo-code:
> +~~~~~~~~~~~~~~~~
> +
> +.. code-block:: text
> +
> +  every sample_ms:
> +    for each CPU:
> +      sample AMU counters (instructions, cycles, cache-misses, stalls)
> +      derive per-CPU IPM, back-end-stall % and write-back ratio
> +
> +    for each configured memory group (DDR / LLCC / DDR_QOS):
> +      for each monitor in the group:
> +        best_freq = 0
> +        for each CPU in the monitor's cpumask:
> +          if CPU is memory-bound (IPM/stall/write-back vs. the
> +             monitor's configured thresholds):
> +            freq = CPU's cpufreq, optionally scaled toward the ceiling
> +            best_freq = max(best_freq, freq)
> +        monitor.target_freq = monitor's cpufreq->memfreq map(best_freq)
> +
> +      group_vote = max(target_freq of every monitor in the group)
> +      if group_vote changed since the last sample:
> +        vote group_vote onto the group's interconnect path
> +
> +  GET_CUR_FREQ returns a monitor's last target_freq
> +  START_TIMER / STOP_TIMER: resume / suspend the loop above
> +
> +MEMLAT: Supported memory buses
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The hw_type field carried in most payloads identifies the memory group:
> +
> ++----------+--------------------------------------------------------------+
> +|hw_type   |Group                                                         |
> ++----------+--------------------------------------------------------------+
> +|0         |DDR                                                           |
> ++----------+--------------------------------------------------------------+
> +|1         |LLCC                                                          |
> ++----------+--------------------------------------------------------------+
> +|2         |DDR_QOS_COMPUTE                                               |
> ++----------+--------------------------------------------------------------+
> +|3         |DDR_QOS_MOBILE                                                |
> ++----------+--------------------------------------------------------------+
> +
> +All multi-byte fields below are little-endian. mon_idx selects a monitor
> +within the group (0-based, less than the firmware-supported maximum). All
> +SET commands return the SCMI status word; on success it carries SUCCESS, on
> +lookup failure INVALID_PARAMETERS, and on an unknown param_id NOT_SUPPORTED.
> +
> +Frequency units are not uniform across commands (kHz, MHz or a raw 0/1
> +DDR_QOS level, depending on the param_id); each command documents its own
> +units below.
> +
> +MEMLAT_SET_MEM_GROUP
> +~~~~~~~~~~~~~~~~~~~~
> +
> +param_id: 0x10 (16)


Ah so, these are param id for the above commands I mentioned as too
ambiguous ? If so, at this point I think it is better to make custom
vendor protocol ID 0x80 for MEMLAT and make all these part of it.
I think my comment of multiplexing is a bad idea seem to be confirmed here.
I will skip the rest as it makes no sense to review it any further.

-- 
Regards,
Sudeep
