From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 08/15] PM / Hibernate: add user module_ops
Date: Fri, 26 Mar 2010 10:43:23 +0100
Message-ID: <4BAC81BB.9030606__21027.8333783664$1269596661$gmane$org@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-8-git-send-email-jslaby@suse.cz>
	<201003252307.15232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003252307.15232.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/25/2010 11:07 PM, Rafael J. Wysocki wrote:
> On Tuesday 23 March 2010, Jiri Slaby wrote:
>> Add sws_module_ops into /dev/snapshot user interface, so far only with
>> .storage_available. The structure will be shortly filled while converting
>> it to ops.
>>
>> Also, when using this interface, switch to the ops on open/release.
> 
> Quite frankly, I don't really understand the purpose of this change in this
> particular form.  It looks like it may be folded into one of the subsequent
> changes just fine.

Yup, maybe the single-change-per-patch approach was overzealous here.
Squashed to 09/15.

thanks,
-- 
js
