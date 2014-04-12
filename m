From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Fwd: New Defects reported by Coverity Scan for Linux
Date: Sat, 12 Apr 2014 07:38:04 -0600
Message-ID: <CAErSpo7cTiZ+Nvii8DXioR9uuAafqXPsWRD-OO0Ei5TLk1fC7w@mail.gmail.com>
References: <5348ea4572e7_5d4d7ac86c27677@209.249.196.67.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37074 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaDLNiY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Apr 2014 09:38:24 -0400
Received: by mail-ig0-f178.google.com with SMTP id hn18so1853164igb.11
        for <linux-pm@vger.kernel.org>; Sat, 12 Apr 2014 06:38:24 -0700 (PDT)
In-Reply-To: <5348ea4572e7_5d4d7ac86c27677@209.249.196.67.mail>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>

Hi Len,

FYI, these were added by 0138d8f0755b ("intel_idle: fine-tune IVT
residency targets").

I think both are the result of missing braces around the "if
(num_sockets > 4)" body.

The "returns" at the end of intel_idle_cpuidle_devices_uninit(),
intel_idle_state_table_update(), and intel_idle_exit() are also
superfluous.

---------- Forwarded message ----------
From:  <scan-admin@coverity.com>
Date: Sat, Apr 12, 2014 at 1:24 AM
Subject: New Defects reported by Coverity Scan for Linux

...

** CID 1201420:  Logically dead code  (DEADCODE)
/drivers/idle/intel_idle.c: 760 in intel_idle_state_table_update()

** CID 1201421:  Nesting level does not match indentation
(NESTING_INDENT_MISMATCH)
/drivers/idle/intel_idle.c: 755 in intel_idle_state_table_update()

...
________________________________________________________________________________________________________
*** CID 1201420:  Logically dead code  (DEADCODE)
/drivers/idle/intel_idle.c: 760 in intel_idle_state_table_update()
754                                             cpuidle_state_table =
ivt_cstates_8s;
755                                             return;
756                             }
757                     }
758
759                     if (num_sockets > 2)
>>>     CID 1201420:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "cpuidle_state_table = ivt_c...".
760                             cpuidle_state_table = ivt_cstates_4s;
761                     /* else, 1 and 2 socket systems use default
ivt_cstates */
762             }
763             return;
764     }
765

________________________________________________________________________________________________________
*** CID 1201421:  Nesting level does not match indentation
(NESTING_INDENT_MISMATCH)
/drivers/idle/intel_idle.c: 755 in intel_idle_state_table_update()
749                             package_num = topology_physical_package_id(cpu);
750                             if (package_num + 1 > num_sockets) {
751                                     num_sockets = package_num + 1;
752
753                                     if (num_sockets > 4)
754                                             cpuidle_state_table =
ivt_cstates_8s;
>>>     CID 1201421:  Nesting level does not match indentation  (NESTING_INDENT_MISMATCH)
>>>     This  statement is indented to column 41, as if it were nested within the preceding parent statement, but it is not.
755                                             return;
756                             }
757                     }
758
759                     if (num_sockets > 2)
760                             cpuidle_state_table = ivt_cstates_4s;

____________________________________________________________
