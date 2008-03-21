From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Sat, 22 Mar 2008 09:05:47 +1100
Message-ID: <1206137147.30885.6.camel__8738.96069028906$1206137387$gmane$org@nigel-laptop>
References: <Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2008-03-20 at 20:52 -0400, Alan Stern wrote:
> For an S5 hibernation, the interpreter state within the image is wrong.  
> The image kernel needs to have the interpreter state from the boot 
> kernel -- I don't know if this is possible.

It's possible.

1) When hibernating, allocate a page (or pages if one isn't enough) for
the data to end up in after the atomic restore.
2) Put the location(s) in the image header.
3) At resume time, allocate an equivalent number of extra 'safe' pages
and set up extra pbes for the atomic restore to copy data from the extra
pages to the ones allocated when hibernating.
4) At the appropriate point in time, copy the NVS data to the extra
'safe' pages allocated in step 3.

The data will then be available to the resumed kernel post-resume.

I've been using this method to pass data from the boot kernel to the
resumed kernel for a while now. (I'm using it for I/O speed statistics
and state preservation).

Regards,

Nigel
