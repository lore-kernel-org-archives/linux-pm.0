From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend and hibernation status report
Date: Sat, 8 Sep 2007 23:40:36 +0200
Message-ID: <200709082340.37018.rjw@sisk.pl>
References: <200707271057.05438.rjw@sisk.pl>
	<200709041932.21281.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709041932.21281.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 5 September 2007 01:32, Len Brown wrote:
> On Friday 27 July 2007 04:57, Rafael J. Wysocki wrote:
> 
> Thanks for writing this, Rafael.
> 
> > * system hibernation state - state, in which the system's processors are off and
> >   its main memory is not powered, but the information necessary for continuing
> >   the computations carried out when the system was last in a working state is
> >   preserved in a storage space, such as a disk
> > * ACPI S4 state - system hibernation state, in which some information is
> >   preserved by the ACPI platform, in accordance with the ACPI specification
> 
> "some information is preserved by the ACPI platform" is sort of mis-leading.
> What ACPI adds to the hibernate flow is some platform hooks to handle
> wakeup devices, and a platform hook for the actual sleep request.
> I'm not aware of any information saved by ACPI during S4 that is
> not saved were the hibernate to be done with "acpi=off".

Well, I am.

On HPC nx6325 the status of AC adapter after the restore is not reported
correctly if hibernation is done without the ACPI hooks (eg. if you hibernate
with the AC connected and then disconnect it and resume, it will still be
reported as connected until you plug/unplug it).

There are more machines that behave similarly, AFAICT.

Greetings,
Rafael
