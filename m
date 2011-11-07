From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Export FADT pm_profile integer value
 to userspace
Date: Sun, 06 Nov 2011 20:50:14 -0500
Message-ID: <4EB73956.50709@kernel.org>
References: <1320374026-4913-1-git-send-email-trenn@suse.de>
	<201111042325.48583.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201111042325.48583.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, "Len Brown (Intel)" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

I guess in theory one could parse the FADT from user-space,
as it is already exported in /sys/firmware/acpi/tables/
but this is certainly more user-friendly -- say
to a shell script etc.

applied.

thanks,
Len Brown, Intel Open Source Technology Center
