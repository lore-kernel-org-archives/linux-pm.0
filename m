From: Len Brown <lenb@kernel.org>
Subject: Re: Suspend and hibernation status report
Date: Tue, 4 Sep 2007 19:32:20 -0400
Message-ID: <200709041932.21281.lenb__7387.02373714677$1188948940$gmane$org@kernel.org>
References: <200707271057.05438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707271057.05438.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 27 July 2007 04:57, Rafael J. Wysocki wrote:

Thanks for writing this, Rafael.

> * system hibernation state - state, in which the system's processors are off and
>   its main memory is not powered, but the information necessary for continuing
>   the computations carried out when the system was last in a working state is
>   preserved in a storage space, such as a disk
> * ACPI S4 state - system hibernation state, in which some information is
>   preserved by the ACPI platform, in accordance with the ACPI specification

"some information is preserved by the ACPI platform" is sort of mis-leading.
What ACPI adds to the hibernate flow is some platform hooks to handle
wakeup devices, and a platform hook for the actual sleep request.
I'm not aware of any information saved by ACPI during S4 that is
not saved were the hibernate to be done with "acpi=off".

thanks,
-Len
