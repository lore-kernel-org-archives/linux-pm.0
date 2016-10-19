From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:device-links-test 2/5] htmldocs: include/linux/device.h:727:
 warning: Enum value 'DL_STATE_NONE' not described in enum
 'device_link_state'
Date: Wed, 19 Oct 2016 21:00:53 +0800
Message-ID: <201610192148.b58KaV90%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37423 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941991AbcJSOcG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Oct 2016 10:32:06 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git device-links-test
head:   37c39b84114b777fdd8ed1a7074c7c0674180533
commit: 5821e59c7551e256b15e164f1c248602f49d1b68 [2/5] driver core: Functional dependencies tracking support
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   make[3]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
   include/linux/init.h:1: warning: no structured comments found
   include/linux/workqueue.h:392: warning: No description found for parameter '...'
   include/linux/workqueue.h:392: warning: Excess function parameter 'args' description in 'alloc_workqueue'
   include/linux/workqueue.h:413: warning: No description found for parameter '...'
   include/linux/workqueue.h:413: warning: Excess function parameter 'args' description in 'alloc_ordered_workqueue'
   include/linux/kthread.h:26: warning: No description found for parameter '...'
   kernel/sys.c:1: warning: no structured comments found
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_NONE' not described in enum 'device_link_state'
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_DORMANT' not described in enum 'device_link_state'
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_AVAILABLE' not described in enum 'device_link_state'
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_CONSUMER_PROBE' not described in enum 'device_link_state'
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_ACTIVE' not described in enum 'device_link_state'
>> include/linux/device.h:727: warning: Enum value 'DL_STATE_SUPPLIER_UNBIND' not described in enum 'device_link_state'
>> include/linux/device.h:770: warning: Enum value 'DL_DEV_NO_DRIVER' not described in enum 'dl_dev_state'
>> include/linux/device.h:770: warning: Enum value 'DL_DEV_PROBING' not described in enum 'dl_dev_state'
>> include/linux/device.h:770: warning: Enum value 'DL_DEV_DRIVER_BOUND' not described in enum 'dl_dev_state'
>> include/linux/device.h:770: warning: Enum value 'DL_DEV_UNBINDING' not described in enum 'dl_dev_state'
>> include/linux/device.h:933: warning: No description found for parameter 'links'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/fence-array.h:61: warning: No description found for parameter 'fence'
   include/sound/core.h:324: warning: No description found for parameter '...'
   include/sound/core.h:335: warning: No description found for parameter '...'
   include/sound/core.h:388: warning: No description found for parameter '...'
   include/media/media-entity.h:1054: warning: No description found for parameter '...'
   include/net/mac80211.h:2148: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:2153: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:3202: ERROR: Unexpected indentation.
   include/net/mac80211.h:3205: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:3207: ERROR: Unexpected indentation.
   include/net/mac80211.h:3208: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:1435: WARNING: Inline emphasis start-string without end-string.
   include/net/mac80211.h:1172: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:1173: WARNING: Inline literal start-string without end-string.
   include/net/mac80211.h:814: ERROR: Unexpected indentation.
   include/net/mac80211.h:815: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:820: ERROR: Unexpected indentation.
   include/net/mac80211.h:821: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:2489: ERROR: Unexpected indentation.
   include/net/mac80211.h:1768: ERROR: Unexpected indentation.
   include/net/mac80211.h:1772: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/net/mac80211.h:1746: WARNING: Inline emphasis start-string without end-string.
   kernel/sched/fair.c:7247: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1230: ERROR: Unexpected indentation.
   kernel/time/timer.c:1232: ERROR: Unexpected indentation.
   kernel/time/timer.c:1233: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:121: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:124: ERROR: Unexpected indentation.
   include/linux/wait.h:126: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:1021: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:317: WARNING: Inline literal start-string without end-string.
   drivers/base/firmware_class.c:1348: WARNING: Bullet list ends without a blank line; unexpected unindent.
   drivers/message/fusion/mptbase.c:5054: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1893: WARNING: Definition list ends without a blank line; unexpected unindent.
   include/linux/spi/spi.h:369: ERROR: Unexpected indentation.
   WARNING: dvipng command 'dvipng' cannot be run (needed for math display), check the imgmath_dvipng setting

vim +727 include/linux/device.h

   721		DL_STATE_DORMANT = 0,
   722		DL_STATE_AVAILABLE,
   723		DL_STATE_CONSUMER_PROBE,
   724		DL_STATE_ACTIVE,
   725		DL_STATE_SUPPLIER_UNBIND,
   726	};
 > 727	
   728	/*
   729	 * Device link flags.
   730	 *
   731	 * STATELESS: The core won't track the presence of supplier/consumer drivers.
   732	 * AUTOREMOVE: Remove this link automatically on consumer driver unbind.
   733	 */
   734	#define DL_FLAG_STATELESS	(1 << 0)
   735	#define DL_FLAG_AUTOREMOVE	(1 << 1)
   736	
   737	/**
   738	 * struct device_link - Device link representation.
   739	 * @supplier: The device on the supplier end of the link.
   740	 * @s_node: Hook to the supplier device's list of links to consumers.
   741	 * @consumer: The device on the consumer end of the link.
   742	 * @c_node: Hook to the consumer device's list of links to suppliers.
   743	 * @status: The state of the link (with respect to the presence of drivers).
   744	 * @flags: Link flags.
   745	 * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
   746	 */
   747	struct device_link {
   748		struct device *supplier;
   749		struct list_head s_node;
   750		struct device *consumer;
   751		struct list_head c_node;
   752		enum device_link_state status;
   753		u32 flags;
   754		struct rcu_head rcu_head;
   755	};
   756	
   757	/**
   758	 * enum dl_dev_state - Device driver presence tracking information.
   759	 * @NO_DRIVER: There is no driver attached to the device.
   760	 * @PROBING: A driver is probing.
   761	 * @DRIVER_BOUND: The driver has been bound to the device.
   762	 * @UNBINDING: The driver is unbinding from the device.
   763	 */
   764	enum dl_dev_state {
   765		DL_DEV_NO_DRIVER = 0,
   766		DL_DEV_PROBING,
   767		DL_DEV_DRIVER_BOUND,
   768		DL_DEV_UNBINDING,
   769	};
 > 770	
   771	/**
   772	 * struct dev_links_info - Device data related to device links.
   773	 * @suppliers: List of links to supplier devices.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KYugWwAA

--IS0zKkzwUGydFO0o--
