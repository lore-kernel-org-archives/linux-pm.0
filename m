From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4] treewide: Fix line continuation formats
Date: Thu, 16 Nov 2017 12:11:13 -0500
Message-ID: <1510852273.3711.448.camel@linux.vnet.ibm.com>
References: <cover.1510845910.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1510845910.git.joe@perches.com>
Sender: linux-media-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-security-module@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-11-16 at 07:27 -0800, Joe Perches wrote:
> Avoid using line continations in formats as that causes unexpected
> output.

Is having lines greater than 80 characters the preferred method?
 Could you add quotes before the backlash and before the first word on
the next line instead?

Mimi
