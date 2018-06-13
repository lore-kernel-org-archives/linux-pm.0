From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC PATCH 02/12] xen/manage: introduce helper function to know
 the on-going suspend mode
Date: Thu, 14 Jun 2018 03:41:55 +1000
Message-ID: <CAKTCnznqA=RcA1VWePn-Yt5AYn2-FKhXRJH8FgHjcG2Gjqc1Ow@mail.gmail.com>
References: <20180612205619.28156-1-anchalag@amazon.com> <20180612205619.28156-3-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612205619.28156-3-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anchal Agarwal <anchalag@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, netdev <netdev@vger.kernel.org>, jgross@suse.com, xen-devel <xen-devel@lists.xenproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kamatam@amazon.com, Frank van der Linden <fllinden@amazon.com>, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 13, 2018 at 6:56 AM, Anchal Agarwal <anchalag@amazon.com> wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
>
> Introduce simple functions which help to know the on-going suspend mode
> so that other Xen-related code can behave differently according to the
> current suspend mode.

I'd squash this patch with the previous, the previous one just left
too many open questions about how suspend mode is used. Looks like
suspend mode is a state, but I am not sure if valid transitions are
defined/checked?

Balbir Singh.
