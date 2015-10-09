From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] Fix cpupower reporting uninitialized values for offline
 cpus
Date: Fri, 09 Oct 2015 08:21:01 -0400
Message-ID: <5617B12D.2070001@redhat.com>
References: <1443726584-18709-1-git-send-email-jtanenba@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443726584-18709-1-git-send-email-jtanenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Tanenbaum <jtanenba@redhat.com>, linux-pm@vger.kernel.org
Cc: trenn@suse.com, shreyas@linux.vnet.ibm.com, rafael.j.wysock@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 10/01/2015 03:09 PM, Jacob Tanenbaum wrote:
> cpupower monitor reports uninitialized values for offline cpus
> 
> [root@hp-dl980g7-02 linux]# cpupower monitor
> ...
> 5472|   0|   1|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
> 10567|   0| 159|******|******|******|******||******|******|******||  0.00|  0.00|  0.00|  0.00|  0.00 *is offline
> 1661206560|859272560| 150|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
> 1661206560|943093104| 140|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
> 
> because of this cpupower also holds the incorrect value for the number
> of physical packages in the machine
> 
> Changed cpupower to initialize the values of an offline cpu's socket and
> core to -1, warn the user that one or more cpus is/are
> offline and not print statistics for offline cpus.
> 
> Thomas Renninger suggested fixing the issue by checking for the
> existence of the topology files which the code already does, so I
> decided to use a check on if the cpu was online.

Thomas, any comment?

Looks good to me.  The description could be cleaned up a bit but I'll let the
maintainer decide if they want a new one.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.
