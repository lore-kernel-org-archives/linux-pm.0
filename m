Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F9372B3C;
	Wed, 29 Jul 2026 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305769; cv=none; b=vGfrhoJvIy93fVvKddSndumqwJXBEwpAKQAVYQyxPMA5vgK1/KNrrHV8r+e2nwIuRGH0c6RMldrBA6+6gU5X/o8UZzxpCAd84gkjaYxZ8wHm6oMGrgC+6vjL0dG7/O5V+H/MfLc2YJtwGwaqWvVW/o0QYVp5cWxzxP3R+5dWE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305769; c=relaxed/simple;
	bh=e8FGAVTT5khFAyFskXVaBczff1W5aySeK9CTbu9nWfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zp1Ij1eKfrzqHSb4sXpTF6og8WuJ6g26lHhfRPVHEQuAQe+TjyTsPjnB6ZptmqPg3heDvIb1X7UN6ARsDLk7vSqsDdODqefE1B8omPFYwxYzHNVm6JJrb/3e6Y18ohLbE+VSXm06liBmIlw7Di4/R6R1uJ0PvKzZmX9I20IAe8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f4c3d9da8b1411f1aa26b74ffac11d73-20260729
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:68a28910-ec20-41a6-ac6c-187de75d6c84,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:68a28910-ec20-41a6-ac6c-187de75d6c84,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:63fb6d16496f8e0ad5477dbb5e0857ce,BulkI
	D:2607291415576EBNHADR,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4c3d9da8b1411f1aa26b74ffac11d73-20260729
X-User: tianyaxiong@kylinos.cn
Received: from tian-x86.. [(106.16.184.249)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 662220583; Wed, 29 Jul 2026 14:15:54 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com,
	lenb@kernel.org,
	pavel@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 0/6] cpuidle: speed up do_idle() by caching the governor latency QoS constraint
Date: Wed, 29 Jul 2026 14:15:49 +0800
Message-ID: <20260729061549.13419-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpuidle_governor_latency_req() is evaluated on every idle-state
selection.  It aggregates the per-CPU resume latency with the global
CPU latency and wakeup latency QoS limits by repeatedly calling
get_cpu_device() and pm_qos_read_value() cpu_latency_qos_limit()
cpu_wakeup_latency_qos_limit().

Use ftrace's function_graph, we can see:
parent:          do_idle
parent_total_ns: 36671010505
parent_count:    5994

SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
--------------------------------------------------------------------------------------------------
do_idle                                                 36671010505  100.00%  100.00%       5994
  cpuidle_idle_call                                     35566528731   96.99%   96.99%       8570
    call_cpuidle                                        35476606844   96.74%   99.75%       8561
      cpuidle_enter                                     35472932468   96.73%   99.99%       8526
    cpuidle_select                                         52097031    0.14%    0.15%       8580
      menu_select                                          49555181    0.14%   95.12%       8580
        tick_nohz_get_sleep_length                         28843887    0.08%   58.21%       8570
        cpuidle_governor_latency_req                        9567488    0.03%   19.31%       8580
        tick_nohz_tick_stopped                              2057031    0.01%    4.15%      15695
    cpuidle_reflect                                        11427201    0.03%    0.03%       8561
      menu_reflect                                          6579506    0.02%   57.58%       8526
        tick_nohz_idle_got_tick                             2231559    0.01%   33.92%       8526
      __sysvec_apic_timer_interrupt                          105520    0.00%    0.92%          3
    tick_nohz_idle_stop_tick                                8279641    0.02%    0.02%       1475
    ---- skip

The majority of the time spent in cpuidle_enter for CPUs entering
idle state has already been charged to the idle path. Among the
remaining contributors, cpuidle_governor_latency_req() accounts 
for a non-negligible portion of the overall latency.

Under the menu governor this shows up hot: ftrace data shows,
 cpuidle_governor_latency_req() accounts for about 19.9% of
menu_select() time (~1.9 us/call).  After caching the aggregated
value per CPU and invalidating via QoS notifiers, that share drops to
about 4.2% (~0.3 us/call), roughly a 6x reduction on this path.

The ftrace data before and after the optimization is shown below:
1) original
parent:          menu_select
parent_total_ns: 160492937
parent_count:    16718

SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
--------------------------------------------------------------------------------------------------
menu_select                                               160492937  100.00%  100.00%      16718
  tick_nohz_get_sleep_length                              100262940   62.47%   62.47%      16698
    tick_nohz_next_event                                   67891299   42.30%   67.71%      16689
      rcu_needs_cpu                                         2825649    1.76%    4.16%      16689
      timekeeping_max_deferment                             2380377    1.48%    3.51%      15296
    hrtimer_next_event_without                             17865162   11.13%   17.82%      15296
      hrtimer_bases_next_event_without                      2707631    1.69%   15.16%      15296
      _raw_spin_lock_irqsave                                2461132    1.53%   13.78%      15296
        native_queued_spin_lock_slowpath                        177    0.00%    0.01%          1
      _raw_spin_unlock_irqrestore                           2364647    1.47%   13.24%      15296
    can_stop_idle_tick                                      2906072    1.81%    2.90%      16698
  cpuidle_governor_latency_req                             31988150   19.93%   19.93%      16718
    get_cpu_device                                          4122502    2.57%   12.89%      16718
    pm_qos_read_value                                       3427318    2.14%   10.71%      16718
    cpu_latency_qos_limit                                   3005804    1.87%    9.40%      16718
    cpu_wakeup_latency_qos_limit                            3005475    1.87%    9.40%      16718
  tick_nohz_tick_stopped                                    4551981    2.84%    2.84%      29496

%ROOT = share of menu_select; %PARENT = share of immediate caller (inclusive)

2) post-optimized
parent:          menu_select
parent_total_ns: 55428604
parent_count:    7626

SYMBOL                                                      TIME_NS    %ROOT  %PARENT      COUNT
--------------------------------------------------------------------------------------------------
menu_select                                                55428604  100.00%  100.00%       7626
  tick_nohz_get_sleep_length                               37464607   67.59%   67.59%       7544
    tick_nohz_next_event                                   24076913   43.44%   64.27%       7522
      get_next_timer_interrupt                             16332381   29.47%   67.83%       5854
      rcu_needs_cpu                                         1489633    2.69%    6.19%       7522
      timekeeping_max_deferment                              870851    1.57%    3.62%       5586
    hrtimer_next_event_without                              6140153   11.08%   16.39%       5586
      hrtimer_bases_next_event_without                       979000    1.77%   15.94%       5586
      _raw_spin_lock_irqsave                                 808786    1.46%   13.17%       5586
      _raw_spin_unlock_irqrestore                            785518    1.42%   12.79%       5586
    can_stop_idle_tick                                      1583137    2.86%    4.23%       7544
  cpuidle_governor_latency_req                              2321119    4.19%    4.19%       7626
  tick_nohz_tick_stopped                                    1863015    3.36%    3.36%      12751

%ROOT = share of menu_select; %PARENT = share of immediate caller (inclusive)

This series:
- patch1~pathc3: Add QoS notifiers-related infrastructure and updates to
latency_req_gen.
- patch4: Implement QoS constraint for cache-aggregated governor latency
- patch5: add latency_req QoS idle-state selection test
- patch6: add idle-state disable selftest

Patch 5 and 6 can be a separate topic.

Changelog:
v2:
- In patch4: 
      1: Fix latency_req_gen zero-initialization causing system to
      2: Remove unnecessary WRITE_ONCE/READ_ONCE and add usage
         restriction comments.
      3: Rename the original cpuidle_governor_latency_req()
         to cpuidle_aggregate_latency_req, and have the new
         cpuidle_governor_latency_req() call it to implement
         caching logic.
- In patch5: 
      1: Factor out common logic in preparation for the idle-state
         disable selftest.
      2: Add a preexisting QoS/disable warning to alert users that
         existing system settings may interfere with the test.
      3: Fix ResumeLatencyGuard value restoration.
- Add patch6 for idle-state disable selftest

V1 link is:
https://lore.kernel.org/linux-pm/20260721092324.17508-1-tianyaxiong@kylinos.cn/

Yaxiong Tian (6):
  pm: qos: add notifiers for CPU latency and wakeup latency QoS
  cpuidle: subscribe to global latency QoS notifiers
  cpuidle: invalidate latency gen on per-CPU resume QoS changes
  cpuidle: cache aggregated governor latency QoS constraint
  selftests/cpuidle: add latency_req QoS idle-state selection test
  selftests/cpuidle: add idle-state disable selftest

 drivers/cpuidle/cpuidle.c                     |  15 +-
 drivers/cpuidle/cpuidle.h                     |   2 +
 drivers/cpuidle/governor.c                    | 148 ++++++++-
 include/linux/pm_qos.h                        |  23 ++
 kernel/power/qos.c                            |  50 ++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/cpuidle/Makefile      |   7 +
 tools/testing/selftests/cpuidle/config        |   3 +
 .../cpuidle/cpuidle_disable_state.py          | 133 +++++++++
 .../cpuidle/cpuidle_latency_req_qos.py        | 280 ++++++++++++++++++
 .../testing/selftests/cpuidle/cpuidle_lib.py  | 226 ++++++++++++++
 tools/testing/selftests/cpuidle/settings      |   2 +
 12 files changed, 885 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100644 tools/testing/selftests/cpuidle/config
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_disable_state.py
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_latency_req_qos.py
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle_lib.py
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.43.0

