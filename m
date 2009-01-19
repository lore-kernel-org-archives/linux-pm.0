From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.29-rc2] First suspend after reboot resumes
	immediately.
Date: Mon, 19 Jan 2009 21:46:26 +0100
Message-ID: <200901192146.26753.rjw__44708.7281536826$1232398699$gmane$org@sisk.pl>
References: <200901192339.03967.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901192339.03967.arvidjaar@mail.ru>
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
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 19 January 2009, Andrey Borzenkov wrote:
> Subsequent suspends seem fine. I suspect it is related to USB controller; 
> but because I see ACPI related message this is sent to linux-acpi as well.
> 
> Specifically, I am suspicious of this:
> 
> [  132.763954] ohci_hcd 0000:00:02.0: wake-up capability enabled by ACPI   
> 
> The controller immediately resumes after any attempt to suspend it, so any 
> autosuspend functionality is currently disabled. But it /looks/ like ACPI 
> somehow tries to do it anyway.
> 
> I can also reproduce it by unloading and reloading USB drivers which 
> supports USB guess.

This looks like http://bugzilla.kernel.org/show_bug.cgi?id=12399 .

Thanks,
Rafael
