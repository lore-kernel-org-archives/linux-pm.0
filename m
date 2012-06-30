From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/8] ACPI sysfs.c strlen fix
Date: Sat, 30 Jun 2012 10:25:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206301023540.29029-100000@netrider.rowland.org>
References: <9f132652d94c96476b0b0a8caf0c10e96ab10fa8.1341032550.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9f132652d94c96476b0b0a8caf0c10e96ab10fa8.1341032550.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Vasilyev <pavel@pavlinux.ru>
List-Id: linux-pm@vger.kernel.org

On Sat, 30 Jun 2012, Len Brown wrote:

> From: Pavel Vasilyev <pavel@pavlinux.ru>
> 
> Current code is ignoring the last character of "enable" and "disable"
> in comparisons.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=33732
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 9f66181..240a244 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -173,7 +173,7 @@ static int param_set_trace_state(const char *val, struct kernel_param *kp)
>  {
>  	int result = 0;
>  
> -	if (!strncmp(val, "enable", strlen("enable") - 1)) {
> +	if (!strncmp(val, "enable", strlen("enable"))) {

Ironically, this is the less efficient of two possible fixes.

It would have been better to leave the "- 1" in place and change strlen 
to sizeof.  That's probably what the original author had in mind.

Alan Stern
