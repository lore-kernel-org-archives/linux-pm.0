From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: -next: no resume from suspend
Date: Mon, 14 Jan 2013 13:53:58 +0100
Message-ID: <50F3FFE6.4090108@suse.cz>
References: <50F3D9E8.6040802@suse.cz> <16191961.j5ydKsJ3d3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <16191961.j5ydKsJ3d3@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: daniel.vetter@ffwll.ch, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/14/2013 01:56 PM, Rafael J. Wysocki wrote:
> On Monday, January 14, 2013 11:11:52 AM Jiri Slaby wrote:
>> Hi,
>>
>> since friday's -next (the last known to be working is the last monday's)
>> I cannot resume from suspend. The last thing I see with
>> no_console_suspend is:
>> i915: No ACPI video bus found
>>
>> But I used to see the message always, so this is no difference. Any idea
>> before I start bisecting?
> 
> Well, what's the next message you normally see with no_console_suspend?

[drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0

Adding DRM and intel guys.

-- 
js
suse labs
