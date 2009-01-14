From: "=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=" <arve@android.com>
Subject: Re: [PATCH 03/11] PM: Implement wakelock api.
Date: Wed, 14 Jan 2009 15:28:01 -0800
Message-ID: <d6200be20901141528q5388a6deu7246335d841e5bd0@mail.gmail.com>
References: <1231896476-22445-1-git-send-email-arve@android.com>
	<1231896476-22445-2-git-send-email-arve@android.com>
	<1231896476-22445-3-git-send-email-arve@android.com>
	<1231896476-22445-4-git-send-email-arve@android.com>
	<1231925401.7229.294.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1231925401.7229.294.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 14, 2009 at 1:30 AM, Nigel Cunningham
<ncunningham@crca.org.au> wrote:
> Just one comment here - you're adding new procfs entries. IIRC, sysfs is
> strongly preferred now.

I'm adding one procfs entry for stats/debugging information. The sysfs
rules do not allow this type of data so procfs seemed like the best
fit.

-- =

Arve Hj=F8nnev=E5g
