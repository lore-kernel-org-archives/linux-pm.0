From: Len Brown <lenb@kernel.org>
Subject: Re: Q: x86 suspend/hibernation code consolidation
Date: Fri, 25 Jan 2008 21:47:26 -0500
Message-ID: <200801252147.27254.lenb__38425.7014412016$1201315889$gmane$org@kernel.org>
References: <200801260132.09529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801260132.09529.rjw@sisk.pl>
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
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Friday 25 January 2008 19:32, Rafael J. Wysocki wrote:
> Hi,
> 
> I'd like to move the 64-bit suspend/hibernation files from arch/x86/kernel to
> arch/x86/power, modify the names of the 32-bit files already in
> arch/x86/power and update the Makefiles accordingly, but there are some changes
> queued for merging that touch the files in question.
> 
> When is the right time for making changes like that?
> 
> Rafael

In Cambridge, when we discussed cleanups that touch a lot of files
but have no functional change -- somebody suggested that right
after rc1 closes is a good time.  The reasoning was that they
would not conflict with the functional changes in rc1.

However, I recall Linus saying something about "Andrew is special"
WRT permission to push cleanups after the rc1 window; so I don't
know what the final ruling was -- if there was such a ruling.

-Len
