From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 2/2] libata: PM code cleanup for ata port
Date: Fri, 25 Jan 2013 15:34:03 -0500
Message-ID: <5102EC3B.9040901@pobox.com>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com> <50FDA8B3.6090100@pobox.com> <20130125062935.GA9779@aaronlu.sh.intel.com> <510226F9.5000709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <510226F9.5000709@intel.com>
Sender: linux-ide-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 01/25/2013 01:32 AM, Aaron Lu wrote:
> For system freeze, if the port is already runtime suspended, leave it
> alone and just return. The port will be resumed on thaw before it will
> be used.
>
> And since we will call get_noresume for every device during prepare
> phase, and the port is resumed during thaw phase, it can't be in runtime
> suspended state during the poweroff phase. So remove the
> runtime_suspended check in poweroff callback.
>
> And for all suspend(freeze/suspend/poweroff/etc.), there is no need to
> touch the device, so set no_autopsy and no_recovery for them all.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>   drivers/ata/libata-core.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)

applied 1-2



