Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2B37E5C5
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061000; cv=none; b=l/3qBFxa3ExpIlz9vINF5n0rI4ariWC17zR69bePTlpTFnvp4lMhvM86rZS05U6C2AxkHwAcneJp5n3Tvm6BnrYyg4h6RmZZxVHH8RDqEOrKUlGP0wf1MNQhCrTSPXjUqJsTQZGEvsZlYSTtA4lrXcHNHq5QmIIsQ/EVMWSUwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061000; c=relaxed/simple;
	bh=1OZ/ItQmvcOi4wfkW/31N9/v4LF2+SHKTqUTxgY70x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMGZZmbwaWISCegoQYjaFaSRDpkHIy9JLVZ8Q7NkHI5kLxBSuhv1qJkY8TVWgrblYYA/D/WjwZSQJ3AER5Qf6GiiIYgwbgyHm8Fc1r/1LGx68Elj/oxA6fGBimXbTI7886lW/8t3EzTa3lPMAhIeypoHR4oImpHvlJQUf2Cxzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=CDHkXlC4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="CDHkXlC4"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso4628288a91.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1784060998; x=1784665798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+nFGCNJT+qBca0G3lZDgeTtwSwP+svQar++woSWxRxU=;
        b=CDHkXlC4ombHsyXk50VHKdaOxFXpKi97P+laP74EJ9qWBVP4dBhAoqX56LIw+OBpcG
         8Pv+2BGHK5fekFINF+lHcK3QBK81j5PRzuWO0i1m/ecL3Y3KLSNyGoUV2csql57XXNAy
         Qvxp34hUn7XWe6APujkJ4F9ylVmdGvnWb/mupXM9rbaRtSwt5wGxzhs04tvIlaZdO+BZ
         EYRR8R24OYK3e+vPSrRlrwWRnlNjq/daTXOaRcSFFVOQWE0rJDRyLtjIC56aMR2FbwYe
         5jgJgx8EL5U8waqnUR4hYxPbs+evR0+kgnGFmqGfAmDpRK8fZRs546SIn5DhaqoYcQg6
         7dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784060998; x=1784665798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+nFGCNJT+qBca0G3lZDgeTtwSwP+svQar++woSWxRxU=;
        b=f1rQrYl5mufkpLuv0lqyRhTEMkuObXf1vTljwMUIfvOglTspuFKArDak82yE1Tc5aI
         QXqcD1I2YZwPEXgjK9I81XX8cGA55KCr+BFJIAZPzqOiQy9g14eXlqThl67A4Kkz4RU7
         wkLOU4eHc3YoJHGCcHgJUsjl5M39xyQK0PAkJxmGsBpW2RgTiQFntX2pp18JvCZa3qz2
         YZuLBoQI6QTdpcdCP9I59w2Fi9yjuBMbFhK8ABvtXuqU/DqF0kohgXr6vHDsLPhA0YsO
         Lxf/kbxJz9AKLoRxrZb/VSz5ceOqB/SYQiLGcyrgg8Z3sqw40y9UWGlDJugkBRqJvN1h
         4rhg==
X-Forwarded-Encrypted: i=1; AHgh+RomSTPOWBGkZsnG8ojlWgHTS7jKYzhSKHg0lScswcdrIYhJEWIrEHhWh6g64+hWiD9h9kIllqkJwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEE10WXbnp1s9F5zpvRKckW9gHYl1YcBKD9g8pvDY4GqdfhuxO
	jfMyeha/yItkH/Y+221ORGGeicqww3B6h9wSx6lVRhGb+52u0odfD22CQdvaU84RRK8=
X-Gm-Gg: AfdE7cnnAOBG/CRrypJEme+9AYFdD14SSJKmrprWpDU49z9SVv1HvWhIv76gR5zzHcG
	dGQvTYYYb6Tdp9hfUdAy+WPonFIr1SqEPb95Cl+Gg3wKMfFQS/jPw3+xWv/M2Zr7t/+K6d0gTrH
	BJ0hiICG06p5+VlZnhdH06W1ZRju/kvUe5JCq6C1gElxtKm+vL41CMVuV40AVtsqYe73A0zE5rO
	rSBQiIvZGC+tR3rLYOYULjwMysB/UIwXvpShf+GkZw58a8bPalxgaKPuXewhcdxhIlCTJlu00/r
	cw9GrgVJWH+WJ4BIO72iWr4tRzZODFaE6EvGNOPOOFmcN5hGtklYWFPVAuPelEqEZmgNG4u6EOI
	lZlDhtnoqlAkQ4vE6u7B8/RuPC2MDR7bdlskpHoOrypk3YCzAmpk0DnjnyINR2Dy4EFpunmQlvn
	L8DftAS2JoIX+BswdQbJ2Db9ziksuuQiq7MdVZ9WECkRfqZ5ayYw==
X-Received: by 2002:a05:6a21:489:b0:3bf:98fc:3054 with SMTP id adf61e73a8af0-3c36c3e7591mr134059637.56.1784060998265;
        Tue, 14 Jul 2026 13:29:58 -0700 (PDT)
Received: from guest1.. (charm.ics.uci.edu. [128.195.4.118])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm150647131c88.14.2026.07.14.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:29:57 -0700 (PDT)
From: Priya Bala Govindasamy <pgovind2@uci.edu>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: ardalan@uci.edu,
	zhiyunq@cs.ucr.edu,
	dzueck@uci.edu,
	ytan089@ucr.edu,
	pgovind2@uci.edu
Subject: [PATCH 0/1] rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBuilder::to_table
Date: Tue, 14 Jul 2026 20:29:56 +0000
Message-Id: <cover.1783548374.git.pgovind2@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux Kernel Maintainers,

The `TableBuilder::to_table` function adds `Hertz(c_ulong::MAX).as_khz()` 
as the last frequency entry in the frequency table. 
But the C API expects the last entry to have frequency set to 
`CPUFREQ_TABLE_END` which is `~1u` as per include/linux/cpufreq.h.

This prevents insertions of cpufreq modules that use the Rust API 
to build frequency tables.

Here is a PoC kernel module that uses the Rust API to build a frequency 
table and register a cpufreq driver. This module fails to load with the 
attached error message.

  // SPDX-License-Identifier: GPL-2.0

  //! Rust cpufreq proof-of-concept driver

  use core::sync::atomic::{AtomicU32, Ordering};

  use kernel::{
      bindings,
      clk::Hertz,
      cpufreq,
      error::code::*,
      macros::vtable,
      prelude::*,
      sync::Arc,
  };

  const LOW_FREQ: Hertz = Hertz::from_mhz(1000);
  const HIGH_FREQ: Hertz = Hertz::from_mhz(2000);
  const BIOS_LIMIT_KHZ: u32 = 424_242;

  module! {
      type: CpuFreqPocModule,
      name: "cpufreq_poc",
      authors: ["Priya Govindasamy"],
      description: "PoC cpufreq driver for the TableBuilder::to_table bug",
      license: "GPL",
  }

  struct CpuFreqPocModule {
      _driver: cpufreq::Registration<CpuFreqPocDriver>,
  }

  struct CpuFreqPocPolicyData {
      table: cpufreq::TableBox,
      current_freq_khz: AtomicU32,
  }

  #[derive(Default)]
  struct CpuFreqPocDriver;

  #[vtable]
  impl cpufreq::Driver for CpuFreqPocDriver {
      const NAME: &'static CStr = c"cpufreq-poc";
      const FLAGS: u16 = 0;
      const BOOST_ENABLED: bool = false;

      type PData = Arc<CpuFreqPocPolicyData>;

      fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
          
          let mut builder = cpufreq::TableBuilder::new();
          builder.add(LOW_FREQ, 0, 0).unwrap();
          builder.add(HIGH_FREQ, 0, 1).unwrap();
          
          let table = builder.to_table().unwrap();
          let cpu = policy.cpu();

          policy.cpus().set(cpu);
          policy
              .set_min(LOW_FREQ)
              .set_max(HIGH_FREQ)
              .set_cpuinfo_min_freq(LOW_FREQ)
              .set_cpuinfo_max_freq(HIGH_FREQ)
              .set_suspend_freq(LOW_FREQ)
              .set_transition_latency_ns(cpufreq::DEFAULT_TRANSITION_LATENCY_NS);

          unsafe { policy.set_freq_table(&table) };

          Ok(Arc::new(
              CpuFreqPocPolicyData {
                  table,
                  current_freq_khz: AtomicU32::new(HIGH_FREQ.as_khz() as u32),
              },
              GFP_KERNEL,
          )?)
      }

      fn verify(data: &mut cpufreq::PolicyData) -> Result {
          data.generic_verify()
      }

      fn target_index(policy: &mut cpufreq::Policy, index: cpufreq::TableIndex) -> Result {
          let Some(data) = policy.data::<Self::PData>() else {
              return Err(ENOENT);
          };

          let table = &data.table;
          let freq = table.freq(index)?;
          let freq_khz = freq.as_khz() as u32;

          data.current_freq_khz.store(freq_khz, Ordering::Relaxed);
          Ok(())
      }

      fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
          let Some(data) = policy.data::<Self::PData>() else {
              return Err(ENOENT);
          };

          let freq = data.current_freq_khz.load(Ordering::Relaxed);

          Ok(freq)
      }

      fn bios_limit(policy: &mut cpufreq::Policy, limit: &mut u32) -> Result {
          *limit = BIOS_LIMIT_KHZ;
          Ok(())
      }

      fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result {
          Ok(())
      }
  }

  impl kernel::Module for CpuFreqPocModule {
      fn init(_module: &'static ThisModule) -> Result<Self> {
          let driver = match cpufreq::Registration::<CpuFreqPocDriver>::new() {
              Ok(driver) => driver,
              Err(err) => {
                  pr_err!(
                      "cpufreq_poc: cpufreq driver registration failed: errno={}\n",
                      err.to_errno()
                  );
                  return Err(err);
              }
          };

          Ok(Self { _driver: driver })
      }
  }

  impl Drop for CpuFreqPocModule {
      fn drop(&mut self) {
          pr_info!("cpufreq_poc: unloaded\n");
      }
  }


Output:
==================================================================
[ 1166.691889] BUG: KASAN: slab-out-of-bounds in cpufreq_frequency_table_cpuinfo+0x141/0x2c0
[ 1166.692782] Read of size 4 at addr ffff888281ddc038 by task insmod/5462

[ 1166.693721] CPU: 13 UID: 0 PID: 5462 Comm: insmod Tainted: G           OE       7.2.0-rc1+ #27 PREEMPT(lazy) 
[ 1166.693730] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 1166.693732] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[ 1166.693735] Call Trace:
[ 1166.693740]  <TASK>
[ 1166.693749]  dump_stack_lvl+0x97/0xe0
[ 1166.693773]  print_report+0x175/0x6f0
[ 1166.693794]  ? __virt_addr_valid+0x33e/0x3a0
[ 1166.693810]  ? cpufreq_frequency_table_cpuinfo+0x141/0x2c0
[ 1166.693814]  ? kasan_complete_mode_report_info+0x45/0x230
[ 1166.693825]  ? cpufreq_frequency_table_cpuinfo+0x141/0x2c0
[ 1166.693829]  kasan_report+0xe4/0x120
[ 1166.693832]  ? cpufreq_frequency_table_cpuinfo+0x141/0x2c0
[ 1166.693837]  ? rust_helper_krealloc_node_align+0xd/0x20
[ 1166.693861]  __asan_report_load4_noabort+0x18/0x20
[ 1166.693865]  cpufreq_frequency_table_cpuinfo+0x141/0x2c0
[ 1166.693869]  ? __pfx__RNvXs_NtCsbuTvttuFvbr_6kernel3fmtINtB4_7AdapterRmENtNtCsjYlAz7NZ3Sw_4core3fmt7Display3fmtCsgx7gD2tBKZx_12to_table_poc+0x10/0x10 [to_table_poc]
[ 1166.693879]  cpufreq_table_validate_and_sort+0x56/0x390
[ 1166.693883]  ? _RNvMsf_NtCsbuTvttuFvbr_6kernel7cpufreqINtB5_12RegistrationNtCsgx7gD2tBKZx_12to_table_poc16CpuFreqPocDriverE13init_callbackBW_+0x22/0x120 [to_table_poc]
[ 1166.693889]  cpufreq_online+0xb0f/0x22a0
[ 1166.693895]  cpufreq_add_dev+0x70/0x160
[ 1166.693900]  subsys_interface_register+0x273/0x360
[ 1166.693923]  cpufreq_register_driver+0x387/0x580
[ 1166.693933]  _RNvXCsgx7gD2tBKZx_12to_table_pocNtB2_16CpuFreqPocModuleNtCsbuTvttuFvbr_6kernel6Module4init+0x98/0x1d0 [to_table_poc]
[ 1166.693938]  ? stack_depot_save_flags+0x185/0x6e0
[ 1166.693953]  ? __pfx__RNvXs_NtCsbuTvttuFvbr_6kernel3fmtINtB4_7AdapterRmENtNtCsjYlAz7NZ3Sw_4core3fmt7Display3fmtCsgx7gD2tBKZx_12to_table_poc+0x10/0x10 [to_table_poc]
[ 1166.693961]  init_module+0x15/0xff0 [to_table_poc]
[ 1166.693966]  do_one_initcall+0x118/0x4e0
[ 1166.693973]  ? do_init_module+0x63/0x740
[ 1166.694026]  ? __pfx_init_module+0x10/0x10 [to_table_poc]
[ 1166.694030]  ? __se_sys_finit_module+0x39d/0x5f0
[ 1166.694033]  ? __x64_sys_finit_module+0x7f/0x90
[ 1166.694036]  ? x64_sys_call+0xa72/0x3030
[ 1166.694040]  ? do_syscall_64+0x152/0x460
[ 1166.694064]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1166.694073]  ? kvm_sched_clock_read+0x15/0x40
[ 1166.694082]  ? __lock_acquire+0xd2f/0xe80
[ 1166.694096]  ? kvm_sched_clock_read+0x15/0x40
[ 1166.694101]  ? debug_smp_processor_id+0x1b/0x30
[ 1166.694106]  ? _raw_spin_unlock_irqrestore+0x38/0x90
[ 1166.694114]  ? __this_cpu_preempt_check+0x17/0x20
[ 1166.694118]  ? lockdep_hardirqs_on+0xdb/0x160
[ 1166.694123]  ? debug_smp_processor_id+0x1b/0x30
[ 1166.694128]  ? kasan_save_alloc_info+0x3a/0x50
[ 1166.694132]  ? __kasan_kmalloc+0x94/0xb0
[ 1166.694138]  ? __kmalloc_cache_noprof+0x366/0x720
[ 1166.694151]  ? do_init_module+0x63/0x740
[ 1166.694154]  ? __kmalloc_cache_noprof+0x160/0x720
[ 1166.694158]  ? kasan_unpoison+0x4c/0x70
[ 1166.694162]  ? kasan_poison+0x44/0x60
[ 1166.694168]  do_init_module+0x23f/0x740
[ 1166.694176]  load_module+0x323c/0x3eb0
[ 1166.694188]  __se_sys_finit_module+0x39d/0x5f0
[ 1166.694202]  __x64_sys_finit_module+0x7f/0x90
[ 1166.694206]  x64_sys_call+0xa72/0x3030
[ 1166.694227]  do_syscall_64+0x152/0x460
[ 1166.694232]  ? debug_smp_processor_id+0x1b/0x30
[ 1166.694238]  ? do_syscall_64+0x39/0x460
[ 1166.694242]  ? __this_cpu_preempt_check+0x17/0x20
[ 1166.694247]  ? do_syscall_64+0x106/0x460
[ 1166.694250]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1166.694254]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1166.694257] RIP: 0033:0x7f809171e90d
[ 1166.694272] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f3 b4 0f 00 f7 d8 64 89 01 48
[ 1166.694278] RSP: 002b:00007ffd0c3840c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[ 1166.694290] RAX: ffffffffffffffda RBX: 000055b8afd917d0 RCX: 00007f809171e90d
[ 1166.694292] RDX: 0000000000000000 RSI: 000055b898d74cd2 RDI: 0000000000000003
[ 1166.694294] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1166.694296] R10: 0000000000000003 R11: 0000000000000246 R12: 000055b898d74cd2
[ 1166.694298] R13: 000055b8afd91790 R14: 000055b898d73888 R15: 000055b8afd918e0
[ 1166.694306]  </TASK>

[ 1166.731860] Allocated by task 5462:
[ 1166.732274]  kasan_save_track+0x2f/0x70
[ 1166.732283]  kasan_save_alloc_info+0x3a/0x50
[ 1166.732287]  __kasan_kmalloc+0x94/0xb0
[ 1166.732292]  __kmalloc_node_track_caller_noprof+0x53f/0x830
[ 1166.732298]  krealloc_node_align_noprof+0x189/0x3b0
[ 1166.732302]  rust_helper_krealloc_node_align+0xd/0x20
[ 1166.732308]  _RNvMs6_NtCsbuTvttuFvbr_6kernel7cpufreqNtB5_12TableBuilder3add+0x11e/0x2f0
[ 1166.732326]  _RNvMs6_NtCsbuTvttuFvbr_6kernel7cpufreqNtB5_12TableBuilder8to_table+0x3b/0x360
[ 1166.732332]  _RNvXs2_Csgx7gD2tBKZx_12to_table_pocNtB5_16CpuFreqPocDriverNtNtCsbuTvttuFvbr_6kernel7cpufreq6Driver4init+0x9a/0x630 [to_table_poc]
[ 1166.732340]  _RNvMsf_NtCsbuTvttuFvbr_6kernel7cpufreqINtB5_12RegistrationNtCsgx7gD2tBKZx_12to_table_poc16CpuFreqPocDriverE13init_callbackBW_+0x22/0x120 [to_table_poc]
[ 1166.732347]  cpufreq_online+0x920/0x22a0
[ 1166.732351]  cpufreq_add_dev+0x70/0x160
[ 1166.732355]  subsys_interface_register+0x273/0x360
[ 1166.732360]  cpufreq_register_driver+0x387/0x580
[ 1166.732365]  _RNvXCsgx7gD2tBKZx_12to_table_pocNtB2_16CpuFreqPocModuleNtCsbuTvttuFvbr_6kernel6Module4init+0x98/0x1d0 [to_table_poc]
[ 1166.732371]  init_module+0x15/0xff0 [to_table_poc]
[ 1166.732377]  do_one_initcall+0x118/0x4e0
[ 1166.732381]  do_init_module+0x23f/0x740
[ 1166.732386]  load_module+0x323c/0x3eb0
[ 1166.732390]  __se_sys_finit_module+0x39d/0x5f0
[ 1166.732394]  __x64_sys_finit_module+0x7f/0x90
[ 1166.732398]  x64_sys_call+0xa72/0x3030
[ 1166.732403]  do_syscall_64+0x152/0x460
[ 1166.732408]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[ 1166.732614] The buggy address belongs to the object at ffff888281ddc000
                which belongs to the cache kmalloc-64 of size 64
[ 1166.733704] The buggy address is located 8 bytes to the right of
                allocated 48-byte region [ffff888281ddc000, ffff888281ddc030)

[ 1166.734993] The buggy address belongs to the physical page:
[ 1166.735584] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888281ddce00 pfn:0x281ddc
[ 1166.735595] flags: 0x17ffffc0000200(workingset|node=0|zone=2|lastcpupid=0x1fffff)
[ 1166.735606] page_type: f5(slab)
[ 1166.735614] raw: 0017ffffc0000200 ffff8881000428c0 ffff888100040590 ffff888100040590
[ 1166.735618] raw: ffff888281ddce00 000000080020001c 00000000f5000000 0000000000000000
[ 1166.735620] page dumped because: kasan: bad access detected

[ 1166.735783] Memory state around the buggy address:
[ 1166.736299]  ffff888281ddbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1166.737006]  ffff888281ddbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1166.737654] >ffff888281ddc000: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
[ 1166.738309]                                         ^
[ 1166.738769]  ffff888281ddc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1166.739582]  ffff888281ddc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1166.740331] ==================================================================




Priya Bala Govindasamy (1):
  rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in
    TableBuilder::to_table

 rust/kernel/cpufreq.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.34.1

